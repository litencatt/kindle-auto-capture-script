-- 対象アプリ
set target to "Kindle"

-- 保存フォルダ
set savepath to "~/Desktop/Test/"
do shell script "mkdir " & savepath

-- 開始ファイル番号
set spage to 1
-- ページ数
set pages to 400
-- めくり方向(1=左 2=右)
set pagedir to 2
-- ページめくりウエイト(秒)
set pausetime to 1.0

if pagedir = 1 then
	set keychar to (ASCII character 28)
else
	set keychar to (ASCII character 29)
end if

if target is not "" then
	tell application target
		activate
	end tell
end if

delay pausetime
repeat with i from spage to pages
	if i < 10 then
		set dp to "00" & i
	else if i < 10000000 then
		set dp to "0" & i
	end if

	set spath to (savepath & "p" & dp & ".png")
	do shell script "screencapture -x " & spath

	tell application "System Events"
		keystroke keychar
	end tell

	delay pausetime
end repeat
activate
