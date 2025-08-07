#!/bin/bash

# Azure Deployment Script for LiveSportUpdates (Student Account - Fixed)
echo "🚀 Starting Azure deployment for LiveSportUpdates..."

# Variables optimized for Azure for Students with working region
RESOURCE_GROUP="rg-livesport-$(date +%s)"
APP_SERVICE_PLAN="asp-livesport-$(date +%s)"
APP_NAME="livesport-$(date +%s)"
LOCATION="centralindia"  # This should work based on your policy
SKU="F1"  # FREE tier for students

echo "📋 Deployment Configuration:"
echo "   Resource Group: $RESOURCE_GROUP"
echo "   App Service Plan: $APP_SERVICE_PLAN"
echo "   App Name: $APP_NAME"
echo "   Location: $LOCATION"
echo "   SKU: $SKU (FREE TIER)"
echo ""

echo "Creating resources..."

# Create resource group
echo "📦 Creating resource group..."
az group create --name $RESOURCE_GROUP --location $LOCATION

if [ $? -eq 0 ]; then
    echo "✅ Resource group created successfully!"
    
    # Create App Service plan with Free tier
    echo "⚙️  Creating App Service plan (FREE tier)..."
    az appservice plan create \
      --name $APP_SERVICE_PLAN \
      --resource-group $RESOURCE_GROUP \
      --location $LOCATION \
      --sku $SKU \
      --is-linux

    if [ $? -eq 0 ]; then
        echo "✅ App Service plan created successfully!"
        
        # Create the web app
        echo "🌐 Creating Web App..."
        az webapp create \
          --resource-group $RESOURCE_GROUP \
          --plan $APP_SERVICE_PLAN \
          --name $APP_NAME \
          --runtime "NODE:20-lts"

        if [ $? -eq 0 ]; then
            echo "✅ Web App created successfully!"
            
            # Configure app settings
            echo "⚙️  Configuring app settings..."
            az webapp config appsettings set \
              --resource-group $RESOURCE_GROUP \
              --name $APP_NAME \
              --settings \
                NODE_ENV=production \
                WEBSITE_NODE_DEFAULT_VERSION=20.x \
                SCM_DO_BUILD_DURING_DEPLOYMENT=true

            # Set startup command
            az webapp config set \
              --resource-group $RESOURCE_GROUP \
              --name $APP_NAME \
              --startup-file "npm run build && npm start"

            # Get deployment URL
            DEPLOY_URL=$(az webapp show --resource-group $RESOURCE_GROUP --name $APP_NAME --query defaultHostName --output tsv)

            echo ""
            echo "🎉 SUCCESS! Deployment completed!"
            echo "🌐 Your app URL: https://$DEPLOY_URL"
            echo "📁 App Name: $APP_NAME"
            echo "📁 Resource Group: $RESOURCE_GROUP"
            echo ""
            echo "⚠️  SAVE THESE DETAILS:"
            echo "   - App Name: $APP_NAME"
            echo "   - Resource Group: $RESOURCE_GROUP"
            echo "   - URL: https://$DEPLOY_URL"
            echo ""
            echo "📋 Next steps:"
            echo "1. Build your frontend: cd frontend && npm run build"
            echo "2. Deploy your code using one of these methods:"
            echo "   a) Local Git: az webapp deployment source config-local-git --name $APP_NAME --resource-group $RESOURCE_GROUP"
            echo "   b) GitHub Actions: Use the .github/workflows/azure-deploy.yml file"
            echo "   c) VS Code Azure extension"
            echo "3. Visit your app at: https://$DEPLOY_URL"
        else
            echo "❌ Failed to create Web App"
        fi
    else
        echo "❌ Failed to create App Service plan"
    fi
else
    echo "❌ Failed to create resource group"
fi
