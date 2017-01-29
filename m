From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] i2c: busses: constify i2c_algorithm structures
Date: Sun, 29 Jan 2017 11:28:16 +0100
Message-ID: <20170129102816.274ogzwmtltofrdu@pengutronix.de>
References: <1485540377-13686-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1485540377-13686-1-git-send-email-bhumirks@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: jdelvare@suse.com, andriy.shevchenko@linux.intel.com, kernel@stlinux.com, wsa@the-dreams.de, patrice.chotard@st.com, adi-buildroot-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr, ludovic.desroches@atmel.com, jarkko.nikula@linux.intel.com, linux-i2c@vger.kernel.org, sonic.zhang@analog.com, mika.westerberg@linux.intel.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-i2c@vger.kernel.org

Hello,

On Fri, Jan 27, 2017 at 11:36:17PM +0530, Bhumika Goyal wrote:
>  drivers/i2c/busses/i2c-imx.c             | 2 +-

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> for
i2c-imx.c

Thanks
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
