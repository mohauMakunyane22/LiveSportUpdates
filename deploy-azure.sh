#!/bin/bash

# Azure Deployment Script for LiveSportUpdates
echo "🚀 Starting Azure deployment for LiveSportUpdates..."

# Variables - CHANGE THESE VALUES
RESOURCE_GROUP="rg-livesportupdates-prod"
APP_SERVICE_PLAN="asp-livesportupdates-prod"
APP_NAME="livesportupdates-$(date +%s)"  # Adds timestamp for uniqueness
LOCATION="southafricanorth"  # Available region for your account
SKU="B1"  # Basic tier - change to F1 for free tier

echo "📋 Deployment Configuration:"
echo "   Resource Group: $RESOURCE_GROUP"
echo "   App Service Plan: $APP_SERVICE_PLAN"
echo "   App Name: $APP_NAME"
echo "   Location: $LOCATION"
echo "   SKU: $SKU"
echo ""

# Login to Azure (will open browser)
echo "🔐 Logging into Azure..."
az login

# Create resource group
echo "📦 Creating resource group..."
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create App Service plan
echo "⚙️  Creating App Service plan..."
az appservice plan create \
  --name $APP_SERVICE_PLAN \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION \
  --sku $SKU \
  --is-linux

# Create the web app
echo "🌐 Creating Web App..."
az webapp create \
  --resource-group $RESOURCE_GROUP \
  --plan $APP_SERVICE_PLAN \
  --name $APP_NAME \
  --runtime "NODE:20-lts" \
  --deployment-local-git

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
echo "✅ Deployment setup complete!"
echo "🌐 Your app URL: https://$DEPLOY_URL"
echo "📁 App Name: $APP_NAME"
echo ""
echo "Next steps:"
echo "1. Build your frontend: cd frontend && npm run build"
echo "2. Deploy your code using GitHub Actions or Git deployment"
echo "3. Visit your app at: https://$DEPLOY_URL"
