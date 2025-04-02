.PHONY: install start nginx-setup clean

# 默认目标
all: install start

# 安装依赖并启动服务
install:
	@if [ ! -d "node_modules" ]; then \
		echo "Installing dependencies..."; \
		npm install; \
	else \
		echo "Dependencies already installed."; \
	fi

# 启动开发服务器
start:
	@echo "Starting development server..."
	@npm start

# 设置 Nginx 配置
nginx-setup:
	@echo "Setting up Nginx configuration..."
	@if [ ! -d "nginx" ]; then \
		mkdir -p nginx/conf.d; \
	fi
	@cp nginx.conf nginx/conf.d/default.conf

# 清理构建文件
clean:
	@echo "Cleaning build files..."
	@rm -rf build
	@rm -rf node_modules

# 构建生产版本
build:
	@echo "Building production version..."
	@npm run build

# 启动生产服务器
prod: build nginx-setup
	@echo "Starting production server..."
	@nginx -c nginx/nginx.conf 