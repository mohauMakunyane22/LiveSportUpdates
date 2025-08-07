#!/bin/bash

# Azure Deployment Script for LiveSportUpdates (Student Account)
echo "🚀 Starting Azure deployment for LiveSportUpdates (Student Account)..."

# Variables optimized for Azure for Students
RESOURCE_GROUP="rg-livesport-$(date +%s)"
APP_SERVICE_PLAN="asp-livesport-$(date +%s)"
APP_NAME="livesport-$(date +%s)"
LOCATION="southafricanorth"  # South Africa North - should be available
SKU="F1"  # FREE tier for students

echo "📋 Deployment Configuration:"
echo "   Resource Group: $RESOURCE_GROUP"
echo "   App Service Plan: $APP_SERVICE_PLAN"
echo "   App Name: $APP_NAME"
echo "   Location: $LOCATION"
echo "   SKU: $SKU (FREE TIER)"
echo ""

# Check available locations for your subscription
echo "🌍 Checking available locations..."
az account list-locations --query "[].{Name:name, DisplayName:displayName}" --output table

echo ""
echo "Creating resources..."

# Create resource group
echo "📦 Creating resource group..."
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create App Service plan with Free tier
echo "⚙️  Creating App Service plan (FREE tier)..."
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
  --runtime "NODE:20-lts"

# Configure app settings
echo "⚙️  Configuring app settings..."
az webapp config appsettings set \
  --resource-group $RESOURCE_GROUP \
  --name $APP_NAME \
  --settings \
    NODE_ENV=production \
    WEBSITE_NODE_DEFAULT_VERSION=20.x

# Get deployment URL
DEPLOY_URL=$(az webapp show --resource-group $RESOURCE_GROUP --name $APP_NAME --query defaultHostName --output tsv)

echo ""
echo "✅ Deployment setup complete!"
echo "🌐 Your app URL: https://$DEPLOY_URL"
echo "📁 App Name: $APP_NAME"
echo "📁 Resource Group: $RESOURCE_GROUP"
echo ""
echo "⚠️  IMPORTANT: Save these details!"
echo "   - App Name: $APP_NAME"
echo "   - Resource Group: $RESOURCE_GROUP"
echo ""
echo "Next steps:"
echo "1. Build your frontend: cd frontend && npm run build"
echo "2. Deploy using Git: az webapp deployment source config-local-git --name $APP_NAME --resource-group $RESOURCE_GROUP"
echo "3. Visit your app at: https://$DEPLOY_URL"
