From: "M'boumba Cedric Madianga" <cedric.madianga@gmail.com>
Subject: Re: [PATCH v7 3/5] ARM: dts: stm32: Add I2C1 support for STM32F429 SoC
Date: Fri, 23 Dec 2016 14:09:21 +0100
Message-ID: <CAOAejn1zHMFNiGc-wVbbkC1-JFzG3sjnnUJogtCp9EeAkWsV5A@mail.gmail.com>
References: <1482413704-17531-1-git-send-email-cedric.madianga@gmail.com>
 <1482413704-17531-4-git-send-email-cedric.madianga@gmail.com>
 <20161222191103.vzmfhnrtrzw2ivwa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161222191103.vzmfhnrtrzw2ivwa@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Patrice Chotard <patrice.chotard@st.com>, linux@armlinux.org.uk, Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

SGksCgoKMjAxNi0xMi0yMiAyMDoxMSBHTVQrMDE6MDAgVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xl
aW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT46Cj4gSGVsbG8sCj4KPiBPbiBUaHUsIERlYyAyMiwg
MjAxNiBhdCAwMjozNTowMlBNICswMTAwLCBNJ2JvdW1iYSBDZWRyaWMgTWFkaWFuZ2Egd3JvdGU6
Cj4+IEBAIC0zMzcsNiArMzUwLDE2IEBACj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgc2xldy1yYXRlID0gPDI+Owo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB9Owo+PiAgICAgICAgICAgICAgICAgICAgICAgfTsKPj4gKwo+PiArICAgICAgICAgICAgICAg
ICAgICAgaTJjMV9waW5zX2I6IGkyYzFAMCB7Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHBpbnMxIHsKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwaW5t
dXggPSA8U1RNMzJGNDI5X1BCOV9GVU5DX0kyQzFfU0RBPjsKPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBkcml2ZS1vcGVuLWRyYWluOwo+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB9Owo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwaW5zMiB7
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGlubXV4ID0gPFNUTTMy
RjQyOV9QQjZfRlVOQ19JMkMxX1NDTD47Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IH07Cj4KPiB0aGUgc2Vjb25kIGRvZXNuJ3QgbmVlZCB0aGUgb3Blbi1kcmFpbiBwcm9wZXJ0eT8g
V2h5PwpJIHRob3VnaHQgdGhhdCBvcGVuLWRyYWluIHdhcyBvbmx5IG5lZWRlZCBmb3IgU0RBIGxp
bmUuCkJ1dCBhZnRlciBkb3VibGUtY2hlY2tpbmcgSTJDIHNwZWNpZmljYXRpb24sIGl0IHNlZW1z
IHRoYXQgU0RBIGFuZCBTQ0wKbGluZXMgbmVlZCBvcGVuLWRyYWluIG9yIG9wZW4tY29sbGVjdG9y
IHRvIHBlcmZvcm0gdGhlIHdpcmVkLUFORApmdW5jdGlvbi4KSSB3aWxsIGRvIHNvbWUgdHJpYWxz
IHdpdGggdGhpcyBjb25maWcgYW5kIHdpbGwgZml4IGl0IGluIHRoZSBWOC4KVGhhbmtzCgo+Cj4+
ICsgICAgICAgICAgICAgICAgICAgICB9Owo+PiAgICAgICAgICAgICAgIH07Cj4KPiBCZXN0IHJl
Z2FyZHMKPiBVd2UKPgo+IC0tCj4gUGVuZ3V0cm9uaXggZS5LLiAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHwgVXdlIEtsZWluZS1Lw7ZuaWcgICAgICAgICAgICB8Cj4gSW5kdXN0cmlhbCBMaW51
eCBTb2x1dGlvbnMgICAgICAgICAgICAgICAgIHwgaHR0cDovL3d3dy5wZW5ndXRyb25peC5kZS8g
IHwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFy
bS1rZXJuZWwK
