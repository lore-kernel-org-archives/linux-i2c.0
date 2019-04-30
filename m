From: Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH] i2c: imx-lpi2c: Use __maybe_unused instead of #if
 CONFIG_PM_SLEEP
Date: Tue, 30 Apr 2019 08:10:21 +0000
Message-ID: <AM0PR04MB42114EDECD01526E128A323E803A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1556607314-32401-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556607314-32401-1-git-send-email-Anson.Huang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-i2c@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZw0KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCAzMCwgMjAxOSAzOjAw
IFBNDQo+IFN1YmplY3Q6IFtQQVRDSF0gaTJjOiBpbXgtbHBpMmM6IFVzZSBfX21heWJlX3VudXNl
ZCBpbnN0ZWFkIG9mICNpZg0KPiBDT05GSUdfUE1fU0xFRVANCj4gDQo+IFVzZSBfX21heWJlX3Vu
dXNlZCBmb3IgcG93ZXIgbWFuYWdlbWVudCByZWxhdGVkIGZ1bmN0aW9ucyBpbnN0ZWFkIG9mICNp
Zg0KPiBDT05GSUdfUE1fU0xFRVAgdG8gc2ltcGx5IHRoZSBjb2RlLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQoNCkFja2VkLWJ5OiBEb25n
IEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KDQpSZWdhcmRzDQpEb25nIEFpc2hlbmcN
Cg0K
