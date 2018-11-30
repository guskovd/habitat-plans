$firefox_bin_path="$(hab pkg path {{ cfg.firefox_pkg }})\core"

$env:PATH="$env:PATH;$firefox_bin_path"
geckodriver.exe --port={{ cfg.port }} --host 0.0.0.0 2>&1 >> {{pkg.svc_data_path}}\geckodriver.log
