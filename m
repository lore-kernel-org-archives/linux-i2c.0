From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH RFC 2/3] i2c-nomadik: turn the platform driver to an amba
 driver
Date: Fri, 01 Jun 2012 10:24:08 +0800
Message-ID: <4FC827C8.20605@linaro.org>
References: <cover.1338398567.git.rubini@gnudd.com>
 <349645b61d0b28f6e84f7ae1f2c8c28e12a11d92.1338398567.git.rubini@gnudd.com>
 <CACRpkdZ79=B8N7omxYY4UPotg8gYotfLeBRViYMr8hA-Uhie0w@mail.gmail.com>
 <4FC72DDF.7080209@codethink.co.uk>
 <CACRpkdZpjn0RBGY+CqqSW3ip0MSQUJSaqN0GD=a4THnPHNM-jg@mail.gmail.com>
 <20120531180204.GA28779@mail.gnudd.com>
 <CACRpkdZXnuQe5NXyQBEZJD71Rs=+wvmXkw-4oT53FdU7KE7m2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CACRpkdZXnuQe5NXyQBEZJD71Rs=+wvmXkw-4oT53FdU7KE7m2g@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: giancarlo.asnaghi@st.com, linux@arm.linux.org.uk, linus.walleij@stericsson.com, srinidhi.kasagar@stericsson.com, Alessandro Rubini <rubini@gnudd.com>, linux-kernel@vger.kernel.org, w.sang@pengutronix.de, STEricsson_nomadik_linux@list.st.com, ben.dooks@codethink.co.uk, linux-i2c@vger.kernel.org, khali@linux-fr.org, linux-arm-kernel@lists.infradead.org, alan@linux.intel.com
List-Id: linux-i2c@vger.kernel.org

T24gMDEvMDYvMTIgMDk6NTMsIExpbnVzIFdhbGxlaWogd3JvdGU6Cj4gT24gRnJpLCBKdW4gMSwg
MjAxMiBhdCAyOjAyIEFNLCBBbGVzc2FuZHJvIFJ1YmluaTxydWJpbmlAZ251ZGQuY29tPiAgd3Jv
dGU6Cj4KPj4gU28gSSdsbCByZXN1Ym1pdCBpbiB0aGUgcmlnaHQgd2F5ICgtTSwgaW5jbHVkZS9s
aW51eC9wbGF0Zm9ybV9kYXRhKQo+PiBhcyBzb29uIGFzIEkgaGF2ZSBpbmZvcm1hdGlvbiBmb3Ig
ZnRkIGZpeHVwLgo+Cj4gT0sgaWYgbm90aGluZyBoYXBwZW5zIHlvdSBjYW4gcHJvYmFibHkganVz
dCBnbyBpbiBhbmQgcGF0Y2g6Cj4gYXJjaC9hcm0vYm9vdC9kdHMvZGI4NTAwLmR0c2kKPgo+IEkg
c3VzcGVjdCBpdCdzIGp1c3QgdGhlIGNvbXBhdGlibGU9IHRoYXQgbmVlZHMgdG8gYmUgY2hhbmdl
ZCB0bwo+ICJhcm0scHJpbWVjZWxsIiBvciBqdXN0IGhhdmUgdGhhdCBzdHJpbmcgYWRkZWQgdG8g
dGhlIG90aGVycyB0aGF0Cj4gYXJlIGFscmVhZHkgdGhlcmUgZm9yIGVhY2ggaTJjIGRldmljZSBl
bnRyeS4KCkkgYWxyZWFkeSBoYXZlIGEgcGF0Y2ggdG8gZW5hYmxlZCBJMkMuIElmIHRoaXMgcGF0
Y2ggZ29lcyBpbiwgSSB3aWxsIGZpeCAKaXQgdXAgdG8gcmVnaXN0ZXIgaXRzZWxmIGFzIGEgUHJp
bWVjZWxsIGRldmljZSBpbnN0ZWFkLiBObyBwcm9ibGVtLgoKLS0gCkxlZSBKb25lcwpMaW5hcm8g
U1QtRXJpY3Nzb24gTGFuZGluZyBUZWFtIExlYWQKTTogKzQ0IDc3IDg4IDYzMyA1MTUKTGluYXJv
Lm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0NzCkZvbGxvdyBMaW5hcm86
IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
