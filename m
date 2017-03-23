From: =?UTF-8?B?6ZmI5Lqu?= <cl@rock-chips.com>
Subject: Re: [PATCH v2 4/6] arm64: dts: rockchip: add core dtsi file for
 RK3328 SoCs
Date: Thu, 23 Mar 2017 10:15:20 +0800
Message-ID: <58D32FB8.9070909@rock-chips.com>
References: <1489670244-13328-1-git-send-email-cl@rock-chips.com>
 <1489670244-13328-5-git-send-email-cl@rock-chips.com>
 <7240249b-690a-5800-0b46-fb93a49e2af1@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7240249b-690a-5800-0b46-fb93a49e2af1@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sudeep Holla <sudeep.holla@arm.com>, heiko@sntech.de
Cc: mark.rutland@arm.com, wsa@the-dreams.de, linux-iio@vger.kernel.org, catalin.marinas@arm.com, shawn.lin@rock-chips.com, will.deacon@arm.com, kever.yang@rock-chips.com, linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com, tony.xie@rock-chips.com, linux-i2c@vger.kernel.org, pmeerw@pmeerw.net, david.wu@rock-chips.com, lars@metafoo.de, zhengxing@rock-chips.com, khilman@baylibre.com, linux-rockchip@lists.infradead.org, jay.xu@rock-chips.com, wxt@rock-chips.com, huangtao@rock-chips.com, devicetree@vger.kernel.org, paweljarosz3691@gmail.com, arnd@arndb.de, yhx@rock-chips.com, zhangqing@rock-chips.com, robh+dt@kernel.org, matthias.bgg@gmail.com, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org, dianders@chromium.org, knaack.h@gmx.de, fabio.estevam@nxp.com, andy.yan@rock-chips.com, rocky.hao@rock-chips.com, shawnguo@kernel.org, afaerber@suse.de, jic23@kernel.
List-Id: linux-i2c@vger.kernel.org

SGksCgrlnKggMjAxN+W5tDAz5pyIMjPml6UgMDI6MDksIFN1ZGVlcCBIb2xsYSDlhpnpgZM6Cj4K
PiBPbiAxNi8wMy8xNyAxMzoxNywgY2xAcm9jay1jaGlwcy5jb20gd3JvdGU6Cj4+IEZyb206IExp
YW5nIENoZW4gPGNsQHJvY2stY2hpcHMuY29tPgo+Pgo+PiBUaGlzIHBhdGNoIGFkZHMgY29yZSBk
dHNpIGZpbGUgZm9yIFJvY2tjaGlwIFJLMzMyOCBTb0NzLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBM
aWFuZyBDaGVuIDxjbEByb2NrLWNoaXBzLmNvbT4KPj4gLS0tCj4+ICAgYXJjaC9hcm02NC9ib290
L2R0cy9yb2NrY2hpcC9yazMzMjguZHRzaSB8IDEzNjIgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEzNjIgaW5zZXJ0aW9ucygrKQo+PiAgIGNyZWF0
ZSBtb2RlIDEwMDY0NCBhcmNoL2FybTY0L2Jvb3QvZHRzL3JvY2tjaGlwL3JrMzMyOC5kdHNpCj4+
Cj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3JvY2tjaGlwL3JrMzMyOC5kdHNp
IGIvYXJjaC9hcm02NC9ib290L2R0cy9yb2NrY2hpcC9yazMzMjguZHRzaQo+PiBuZXcgZmlsZSBt
b2RlIDEwMDY0NAo+PiBpbmRleCAwMDAwMDAwLi5hOTI5NTVjCj4+IC0tLSAvZGV2L251bGwKPj4g
KysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9yb2NrY2hpcC9yazMzMjguZHRzaQo+IFsuLi5dCj4K
Pj4gKwljcHVzIHsKPj4gKwkJI2FkZHJlc3MtY2VsbHMgPSA8Mj47Cj4+ICsJCSNzaXplLWNlbGxz
ID0gPDA+Owo+PiArCj4+ICsJCWNwdTA6IGNwdUAwIHsKPj4gKwkJCWRldmljZV90eXBlID0gImNw
dSI7Cj4+ICsJCQljb21wYXRpYmxlID0gImFybSxjb3J0ZXgtYTUzIiwgImFybSxhcm12OCI7Cj4+
ICsJCQlyZWcgPSA8MHgwIDB4MD47Cj4+ICsJCQllbmFibGUtbWV0aG9kID0gInBzY2kiOwo+PiAr
CQkJY2xvY2tzID0gPCZjcnUgQVJNQ0xLPjsKPiBXaHkgImNsb2NrcyIgcHJvcGVydHkgaXMgcHJl
c2VudCBvbmx5IGZvciBjcHUwID8KPgpJIHdpbGwgYWRkICJjbG9ja3MiIHByb3BlcnR5IGZvciBl
YWNoIGNwdSBub2RlIG5leHQgdmVyc2lvbiwgdGhhbmtzIGZvciAKdGhlIGNvbW1lbnQuCgoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1r
ZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJu
ZWwK
