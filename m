From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] i2c: imx: don't leak the i2c adapter on error
Date: Sat, 6 Apr 2019 17:48:47 +0200
Message-ID: <20190406154847.gknmrvjzebih3tu5@pengutronix.de>
References: <20190401101437.9626-1-laurentiu.tudor@nxp.com>
 <20190403204756.mbc7zc5klfd5zydg@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190403204756.mbc7zc5klfd5zydg@ninjato>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: mojha@codeaurora.org, linux-kernel@vger.kernel.org, leoyang.li@nxp.com, wsa+renesas@sang-engineering.com, linux-imx@nxp.com, kernel@pengutronix.de, laurentiu.tudor@nxp.com, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hey Wolfram,

On Wed, Apr 03, 2019 at 10:47:56PM +0200, Wolfram Sang wrote:
> On Mon, Apr 01, 2019 at 01:14:37PM +0300, laurentiu.tudor@nxp.com wrote:
> > From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > =

> > Make sure to free the i2c adapter on the error exit path.
> > =

> > Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> > Reviewed-by: Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
> > Fixes: e1ab9a468e3b ("i2c: imx: improve the error handling in i2c_imx_d=
ma_request()")
> =

> Applied to for-current, thanks!

Is your tree already stable? If not, would you mind correcting my name
in 9b0a9982d8b465e0394db10f15ba53f1a8d60e21?

Best regards and thanks in advance from Freiburg
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
