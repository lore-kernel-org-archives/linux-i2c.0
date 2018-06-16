From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/2] i2c: algos: bit: revert to fix regression (#200045)
Date: Sat, 16 Jun 2018 22:37:55 +0900
Message-ID: <20180616133757.5994-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, dri-devel@lists.freedesktop.org, Sergey Larin <cerg2010cerg2010@mail.ru>
List-Id: linux-i2c@vger.kernel.org

QSByZWdyZXNzaW9uIHdhcyByZXBvcnRlZCB2aWEgQnVnemlsbGEgYW5kIGEgcmV2ZXJ0IHNlZW1z
IHRvIGJlIHRoZSBiZXN0IGNob2ljZQpmb3Igbm93LiBDaGVjayBwYXRjaCAxIGZvciBkZXRhaWxz
LiBUbyBub3QgbWFrZSB0aGUgc2FtZSBtaXN0YWtlIGFnYWluLCBwYXRjaCAyCmFkZHMgYSBjb21t
ZW50IHNoYXJpbmcgb3VyIGV4cGVyaWVuY2UuCgpXb2xmcmFtIFNhbmcgKDIpOgogIFJldmVydCAi
aTJjOiBhbGdvLWJpdDogaW5pdCB0aGUgYnVzIHRvIGEga25vd24gc3RhdGUiCiAgaTJjOiBhbGdv
czogYml0OiBtZW50aW9uIG91ciBleHBlcmllbmNlIGFib3V0IGluaXRpYWwgc3RhdGVzCgogZHJp
dmVycy9pMmMvYWxnb3MvaTJjLWFsZ28tYml0LmMgfCA4ICsrKystLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKLS0gCjIuMTEuMAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcg
bGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
