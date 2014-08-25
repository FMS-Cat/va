#Visual Anarchist
Processingで作った、主にgifを扱えるVJソフトです。

- gifに特化、ビートシンクループ
- 操作はコマンドベース
- GLSLを用いた高速エフェクト
- 簡易プロジェクションマッピング機能
- MIDI制御も可能（WIP）

ライブラリが二つ必要です。両方とも Sketch > Import Library > Add Library で追加できます。

- GifAnimation
- The MidiBus

#Command List
###gif
- `gif(0-3)` gifを切り替えます。
- `gif(0-3) load (filepath)` gifをロードします。
- `gif(0-3) beat (value)` gifが何拍で一周するかを実数で指定します。

###proc
- `proc` procモードを終了します。
- `proc text` テキストを表示します。
- `proc text (text)` proc textで表示する文を指定します。
- `proc img` 画像を表示します。
- `proc img (filepath)` proc imgで表示する画像を指定します。
- `proc param (value)` procモードのパラメータを0-1で指定します。

###fx
- `fx(0-3) load` エフェクト(GLSL)をロードします。
- `fx(0-3) en` エフェクトを有効化します。
- `fx(0-3) dis` エフェクトを無効化します。
- `fx(0-3) param` エフェクトのパラメータを0-1で指定します。

###bpm / beat
- `bpm (value)` BPMを実数で指定します。
- `tap` Enterキーをリズムに合わせてタップし、BPMを計測します。
- `down` 拍をリセットします。
- `beatview` コンソールの背景が拍のタイミングで点滅します。
- `beat(0-4)` ビート変化をエフェクトのパラメータ(0-3)かprocのパラメータ(4)に割り当てます。
- `beat` ビート変化のパラメータへの割り当てを解除します。
- `beat bas (value)` ビート変化のベースを0-1で指定します。
- `beat env (value)` ビート変化のエンベロープを0-1で指定します。

###mouse
- `mouse(x,y)(0-4)` マウス変化をエフェクトのパラメータ(0-3)かprocのパラメータ(4)に割り当てます。
- `mouse(x,y)` マウス変化のパラメータへの割り当てを解除します。
- `cursor` マウスカーソルの表示 / 非表示を切り替えます。

###pm
- `pm` プロジェクションマッピングモードを変更します。
- `pm(0-3) (0-3)` マッピングをします。0から3まで順番に、左上、右上、左下、右下です。
- `pm(0-3)` pm(0-3) 0 と同義です。
- `pm save` pm.csv として、マッピングした座標のデータを保存します。保存したデータは起動時に読み込まれます。

###preset
- `save` preset.csv として、プリセットを保存します。保存したデータは起動時に読み込まれます。

###yay
- `yay` yay