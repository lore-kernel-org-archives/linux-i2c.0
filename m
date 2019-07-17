From: Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH 2/2] i2c: imx-lpi2c: use devm_platform_ioremap_resource()
 to simplify code
Date: Wed, 17 Jul 2019 10:22:35 +0000
Message-ID: <AM0PR04MB42112856FEC15C74AE18824980C90@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190717084017.30987-1-Anson.Huang@nxp.com>
 <20190717084017.30987-2-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190717084017.30987-2-Anson.Huang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-i2c@vger.kernel.org

PiBGcm9tOiBBbnNvbi5IdWFuZ0BueHAuY29tIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiBTZW50
OiBXZWRuZXNkYXksIEp1bHkgMTcsIDIwMTkgNDo0MCBQTQ0KPiANCj4gVXNlIHRoZSBuZXcgaGVs
cGVyIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSgpIHdoaWNoIHdyYXBzIHRoZQ0KPiBw
bGF0Zm9ybV9nZXRfcmVzb3VyY2UoKSBhbmQgZGV2bV9pb3JlbWFwX3Jlc291cmNlKCkgdG9nZXRo
ZXIsIHRvIHNpbXBsaWZ5DQo+IHRoZSBjb2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5zb24g
SHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQoNCkFja2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFp
c2hlbmcuZG9uZ0BueHAuY29tPg0KDQpSZWdhcmRzDQpBaXNoZW5nDQo=
