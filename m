From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH v4 2/2] i2c: cadence: Check for errata condition
 involving master receive
Date: Wed, 10 Dec 2014 09:45:54 -0800
Message-ID: <6b2bd13bcd934b0fb09712e8950348e6@BN1AFFO11FD005.protection.gbl>
References: <1418211884-5329-1-git-send-email-harinik@xilinx.com>
 <1418211884-5329-3-git-send-email-harinik@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418211884-5329-3-git-send-email-harinik@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harini Katakam <harini.katakam@xilinx.com>
Cc: wsa@the-dreams.de, mark.rutland@arm.com, michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, harinikatakamlinux@gmail.com, harinik@xilinx.com, Vishnu Motghare <vishnum@xilinx.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, 2014-12-10 at 05:14PM +0530, Harini Katakam wrote:
> Cadence I2C controller has the following bugs:
> - completion indication is not given to the driver at the end of
> a read/receive transfer with HOLD bit set.
> - Invalid read transaction are generated on the bus when HW timeout
> condition occurs with HOLD bit set.
>=20
> As a result of the above, if a set of messages to be transferred with
> repeated start includes any transfer following a read transfer,
> completion is never indicated and timeout occurs.
> Hence a check is implemented to return -EOPNOTSUPP for such sequences=
=2E
>=20
> Signed-off-by: Harini Katakam <harinik@xilinx.com>
> Signed-off-by: Vishnu Motghare <vishnum@xilinx.com>
> ---
>=20
> v4:
> Use single dev_warn and make message grep-able.
>=20
> v3:
> Add warning in case of unsupported transfer.
>=20
> v2:
> Dont defeteature repeated start. Just check for unsupported condition=
s in the
> driver and return error.
>=20
> ---
>  drivers/i2c/busses/i2c-cadence.c |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2=
c-cadence.c
> index 5f5d4fa..f9269a6 100644
> --- a/drivers/i2c/busses/i2c-cadence.c
> +++ b/drivers/i2c/busses/i2c-cadence.c
> @@ -541,6 +541,20 @@ static int cdns_i2c_master_xfer(struct i2c_adapt=
er *adap, struct i2c_msg *msgs,
>  	 * processed with a repeated start.
>  	 */
>  	if (num > 1) {
> +		/*
> +		 * This controller does not give completion interrupt after a
> +		 * master receive transfer if HOLD bit is set (repeated start),
> +		 * resulting in SW timeout. Hence, if a receive transfer is
> +		 * followed by any other transfer, an error is returned
> +		 * indicating that this sequence is not supported.
> +		 */
> +		for (count =3D 0; count < num-1; count++) {
> +			if (msgs[count].flags & I2C_M_RD)
> +				dev_warn(adap->dev.parent, "No support for "
> +					 "repeated start when receive is "
> +					 "followed by a transfer\n");

Still not grepable. There must be no line breaks in the string!

	S=C3=B6ren
