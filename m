From: Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH] i2c: imx: Use __maybe_unused instead of #if CONFIG_PM
Date: Sun, 5 May 2019 07:31:21 +0000
Message-ID: <AM0PR04MB4211C748DF192A56F3FE8E8280370@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1557026820-29428-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1557026820-29428-1-git-send-email-Anson.Huang@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "eha@deif.com" <eha@deif.com>, "linux@rempel-privat.de" <linux@rempel-privat.de>, Laurentiu Tudor <laurentiu.tudor@nxp.com>, "peda@axentia.se" <peda@axentia.se>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-i2c@vger.kernel.org

PiBGcm9tOiBBbnNvbiBIdWFuZw0KPiBTZW50OiBTdW5kYXksIE1heSA1LCAyMDE5IDExOjMyIEFN
DQo+IFN1YmplY3Q6IFtQQVRDSF0gaTJjOiBpbXg6IFVzZSBfX21heWJlX3VudXNlZCBpbnN0ZWFk
IG9mICNpZiBDT05GSUdfUE0NCj4gDQo+IFVzZSBfX21heWJlX3VudXNlZCBmb3IgcnVudGltZSBQ
TSByZWxhdGVkIGZ1bmN0aW9ucyBpbnN0ZWFkIG9mICNpZg0KPiBDT05GSUdfUE0gdG8gc2ltcGx5
IHRoZSBjb2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5n
QG54cC5jb20+DQoNClJldmlld2VkLWJ5OiBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAu
Y29tPg0KDQpSZWdhcmRzDQpEb25nIEFpc2hlbmcNCg==
