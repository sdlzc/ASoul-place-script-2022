# Reddit Place Script 2022

[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)

## About

This is a script to draw a image onto r/place (<https://www.reddit.com/r/place/>).

## Features

- Support for multiple accounts
- Determines the cooldown time remaining for each account
- Detects existing matching pixels on the r/place map and skips them
- Automatically converts colors to the r/place color palette

## Requirements

- [Latest Version of Python 3](https://www.python.org/downloads/)
- [A Reddit App Client ID and App Secret Key](https://www.reddit.com/prefs/apps)

## How to Get App Client ID and App Secret Key

你需要为每个帐号生成App client id 和 app secret key。
You need to generate an app client id and app secret key for each account in order to use this script.

### 步骤：
1. 进入网站[https://www.reddit.com/prefs/apps](https://www.reddit.com/prefs/apps)
2. 点击底部的'create (another) app' 按钮
3. 选择'script'选项并在 'about url'和'redirect url'处填入任意网站

+ 初次运行脚本之后生成.env 文件，多帐号可以以数组形式顺序写入对应选项。

Steps:

1. Visit <https://www.reddit.com/prefs/apps>
2. Click "create (another) app" button at very bottom
3. Select the "script" option and fill in the fields with anything

If you don't want to create a development app for each account, you can add each username as a developer in the developer app settings. You will need to duplicate the client ID and secret in .env, though.

## Python Package Requirements

Install requirements from 'requirements.txt' file.

### Windows
```shell
pip install -r requirements.txt
```
### Other OS
```shell
pip3 install -r requirements.txt
```


## 开始

以下为自动生成的.env的内容,请自行替换数组内字符串内容

ENV_PLACE_USERNAME='["developer_username"]'
+ 即为reddit用户名。

ENV_PLACE_PASSWORD='["developer_password"]'
+ 若为apple/google登陆请先重置密码

ENV_PLACE_APP_CLIENT_ID='["app_client_id"]'
+ 下图中'personal use script' 上为'app_client_id'.

ENV_PLACE_SECRET_KEY='["app_secret_key"]'
+ 下图中secret 为 'app_secret_key'

ENV_DRAW_X_START="959"
ENV_DRAW_Y_START="497"
ENV_R_START='["0"]'
ENV_C_START='["0"]'


![instance](https://github.com/Dabrit/ASoul-place-script-2022/blob/main/image_2022-04-02_21-22-36.png)

## Get Started

Create a file called '.env'

Put in the following content:

```text
ENV_PLACE_USERNAME='["developer_username"]'
ENV_PLACE_PASSWORD='["developer_password"]'
ENV_PLACE_APP_CLIENT_ID='["app_client_id"]'
ENV_PLACE_SECRET_KEY='["app_secret_key"]'
ENV_DRAW_X_START="x_position_start_integer"
ENV_DRAW_Y_START="y_position_start_integer"
ENV_R_START='["0"]'
ENV_C_START='["0"]'
```

- ENV_PLACE_USERNAME is an array of usernames of developer accounts
- ENV_PLACE_PASSWORD is an array of the passwords of developer accounts
- ENV_PLACE_APP_CLIENT_ID is an array of the client ids for the app / script registered with Reddit
- ENV_PLACE_SECRET_KEY is an array of the secret keys for the app / script registered with Reddit
- ENV_DRAW_X_START specifies the x position to draw the image on the r/place canvas
- ENV_DRAW_Y_START specifies the y position to draw the image on the r/place canvas
- ENV_R_START is an array which specifies which x position of the original image to start at while drawing it
- ENV_C_START is an array which specifies which y position of the original image to start at while drawing it

### Notes: 
- Multiple fields can be passed into the arrays to spawn a thread for each one.
- Change image.png/.jpg to specify what image to draw. One pixel is drawn every 5 minutes
- PNG has priority over JPG

## Run the Script

```python
python3 main.py
```

## Ubuntu下的更新和运行

需要screen支持，一般自带 要么sudo apt install screen -y

### 手动更新并启动

~~~shell
bash update.sh
~~~

### 设置自动更新重启

```shell
bash crontab.sh
```

### 查看运行状态

~~~shell
# 查看当前运行详情
screen -r redit
# 后台运行：Ctrl + a后输入d
# 查看当前启动的窗口
screen -ls
~~~



## Multiple Workers

If you want two threads drawing the image at once you could have a setup like this:

```text
ENV_PLACE_USERNAME='["developer_username_1", "developer_username_2"]'
ENV_PLACE_PASSWORD='["developer_password_1", "developer_password_2"]'
ENV_PLACE_APP_CLIENT_ID='["app_client_id_1", "app_client_id_2"]'
ENV_PLACE_SECRET_KEY='["app_secret_key_1", "app_secret_key_2"]'
ENV_DRAW_X_START="x_position_start_integer"
ENV_DRAW_Y_START="y_position_start_integer"
ENV_R_START='["0", "0"]'
ENV_C_START='["0", "50"]'
```

The same pattern can be used for multiple drawing at once. Note that the "ENV_PLACE_USERNAME", "ENV_PLACE_PASSWORD", "ENV_PLACE_APP_CLIENT_ID", "ENV_PLACE_SECRET_KEY", "ENV_R_START", and "ENV_C_START" variables MUST be string arrays of the same size.

Also note that I did the following in the above example:

```text
ENV_R_START='["0", "0"]'
ENV_C_START='["0", "50"]'
```

In this case, the first worker will start drawing from (0, 0) and the second worker will start drawing from (0, 50) from the input image.jpg file.

This is useful if you want different threads drawing different parts of the image with different accounts.

## Other Settings

```text
ENV_THREAD_DELAY='0'
ENV_UNVERIFIED_PLACE_FREQUENCY='True'
```

- ENV_THREAD_DELAY Adds a delay between starting a new thread. Can be used to avoid ratelimiting
- ENV_UNVERIFIED_PLACE_FREQUENCY is for setting the pixel place frequency to the unverified account frequency (20 minutes)

- Transparency can be achieved by using the RGB value (69, 42, 0) in any part of your image
- If you'd like, you can enable Verbose Mode by adding --verbose to "python main.py". This will output a lot more information, and not neccessarily in the right order, but it is useful for development and debugging.
## Developing
The nox CI job will run flake8 on the code. You can also do this locally by pip installing nox on your system and running
`nox` in the repository directory.