$chrome_path=$(hab pkg path {{ cfg.chrome_pkg }})
cd $chrome_path\bin
& .\chromedriver.exe --port={{ cfg.port }} --whitelisted-ips= 2>&1 >> {{pkg.svc_data_path}}\chromedriver.log
