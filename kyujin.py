import os

from selenium import webdriver
from selenium.webdriver.common.by import By
from time import sleep


# 出力先ディレクトリを指定
output_dir = ''  # 例: 'C:/Users/yourusername/Documents'
output_file = os.path.join(output_dir, 'elements_output.txt')


# Chromeオプションの設定
chrome_options = webdriver.ChromeOptions()

# Chromeは自動テスト ソフトウェア~~ , Devtools listening~~ を非表示
chrome_options.add_argument('--disable-logging')
chrome_options.add_argument('--log-level=3')
chrome_options.add_experimental_option("excludeSwitches", ['enable-automation', 'enable-logging'])


# WebDriverのインスタンスを作成
driver = webdriver.Chrome(options=chrome_options)

# 指定されたURLを開く
url = '' #URLは削除　必要に応じて追加

driver.get(url)




# 左側のパネルを見つける（提供されたCSSセレクターを使って要素を特定）
#find_element メソッドは、指定した検索条件に一致する最初の要素を見つけます。
#By.CSS_SELECTOR: CSSセレクターを使用して検索

panel = driver.find_element(By.CSS_SELECTOR, '#immersive_desktop_root > div > div.lteri > div.zxU94d.gws-plugins-horizon-jobs__tl-lvc ')
#panel = driver.find_element(By.CSS_SELECTOR, 'div.zxU94d.gws-plugins-horizon-jobs__tl-lvc ')


while True:

    # ページの高さを取得 1647
    fast_height = driver.execute_script("return arguments[0].scrollHeight", panel)

    # 左側のパネルをスクロールダウン
    driver.execute_script('arguments[0].scrollTop = arguments[0].scrollHeight', panel)
    sleep(1)  # ページが読み込まれるのを待つ

    # 新しいページの高さを計測
    last_height = driver.execute_script("return arguments[0].scrollHeight", panel)

    # 要素を取得する
    #elements = driver.find_elements(By.CLASS_NAME, 'vNEEBe')
    elements_vNEEBe = driver.find_elements(By.CLASS_NAME, 'vNEEBe')
    elements_BjJfJf_PUpOsf = driver.find_elements(By.CLASS_NAME, 'mVlBke')
 
    # txtファイルに取得した要素のテキストを出力
    with open(output_file, 'a', encoding='utf-8') as file:
      for element in elements_vNEEBe + elements_BjJfJf_PUpOsf:
        #file.write(element.text + '\n')
        if element.text and element.text.strip():
            file.write(element.text + '\n')

    if fast_height == last_height:
        break  # これ以上スクロールする必要がない場合、ループを終了


# ブラウザを閉じる
driver.quit()

