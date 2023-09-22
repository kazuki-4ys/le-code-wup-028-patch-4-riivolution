# le-code-wup-028-patch-4-riivolution

## 説明

Riivolution限定ではあるが、LE-CODEベースのCT packでUSB GCNコンアダプタを使えるようにするパッチ

あくまで現時点では実験的なものである。

これは[Chadderz氏](https://github.com/Chadderz121)が[brainslug-wii](https://github.com/Chadderz121/brainslug-wii)用のモジュールとして開発したものを単純に移植したものである。

[元のコード](https://github.com/Chadderz121/wup-028-bslug)

## 制限

追加のコードを本来カップ設定に使われる領域の後半に使用する。よって、使用できるカップ数が512、つまりコース数が2048に制限される。

いい意味で狂ってるCT pack以外で2048コース以上使用しているCT Packを見たことないのでこの制限はほぼないものに等しい

このパッチは本来のGCコンの入力値を読み取る関数、振動させる関数を完全に置き換えてるので、Dolphinの場合GCコンが使えなくなる。

Wiiの場合、本体上部の4つのGCコンを差すコネクタが使えなくなる(WiiUと同様 USB GCNコンアダプタは使える。無意味だが)

## 不具合

タイトル画面に入って30フレーム後にUSB GCNを有効化するという裏ワザ?で大分ましにはなったが、

Wiiリモコンの通信が切れると、一切の操作が効かなくなることが時々ある

というより恐らくIOSAsync関連が全滅していると思われる

タイトル画面に入ったらWiiリモコンの電池を抜いて通信を切り、ホームに戻る時に電池をいれる

という面倒臭いことをすれば一応回避はできる

## 配布パッチについて

Releaseに配布していると思う

配布パッチはあくまでbuild36とbuild38用であり、それ以外のバージョンでは使用できない

ソースコードはbuild38用のアドレスになっている

wszstなどで各種パラメーターを設定した後、最後に配布パッチをあてること

ipsパッチとして配布してある。

ipsパッチを適用するツールとして有名なものに[winips](http://smblabo.web.fc2.com/)というものがある。

最近ではipsパッチを適用できる[webアプリ](https://www.romhacking.net/patch/)も登場した

## ビルド

ビルドには最新版の[devkitPPC](https://devkitpro.org/wiki/Getting_Started),[Python 3.x](https://www.python.org/downloads/)(3.11.x推奨), [LE-CODE build38](https://wiki.tockdom.com/wiki/LE-CODE)が必要です。

## About it

It was created as a sub-project of [KZ-RTD](https://github.com/kazuki-4ys/kz_rtd). Therefore, the source code contains a lot of unnecessary code.

Patch to enable USB GCN adapter via Riivolution distributed as a patch for LE-CODE.

Too unstable at this time.

A port of [Chadderz's](https://github.com/Chadderz121) code written as a [brainslug-wii](https://github.com/Chadderz121/brainslug-wii) module.

[Original code](https://github.com/Chadderz121/wup-028-bslug)

## Limitation

Use the second half of the area used for cup setting as additional codes.

Therefore, course slots are limited to 2048.

This patch completely replaces the original functions related to GCN controller. Therefore,

Dolphin: GCN controller is completely useless.

Real Wii console: GCN controller adapter attached to the top of the unit will not work.(Of course, you can use the USB GCN adapter.)

## Issue

Changing the code to activate the USB GCN Con 30 frames after entering the title scene has helped a lot, 

but sometimes the GCN controller and the Wii Remotes will not respond at all 

when the communication with the Wii Remotes is lost.

(This issue can be avoided by removing the batteries from the Wii Remote after entering the title scene.)

## About distributed patches

The distributed patches are only for build36 and build38, and cannot be used for other versions.

The source code is addressed for build38.

After setting various parameters with wszst, etc., the last step is to apply distributed patch.

These are ips pathes.

You can apply the ips patch in the [web app](https://www.romhacking.net/patch/).

## Building

The latest versions of [devkitPPC](https://devkitpro.org/wiki/Getting_Started), [Python 3.x](https://www.python.org/downloads/)(3.11.x recommended), [LE-CODE build38](https://wiki.tockdom.com/wiki/LE-CODE) is required.