From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH] i2c-cadence: Do not let signals interrupt I2C transfers
Date: Mon, 10 Mar 2014 14:59:52 -0700
Message-ID: <7e690272-651a-4170-8559-cc8dc8014251@AM1EHSMHS013.ehs.local>
References: <1394449954-10797-1-git-send-email-mike.looijmans@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1394449954-10797-1-git-send-email-mike.looijmans@topic.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>, Michal Simek <michal.simek@xilinx.com>
Cc: git@xilinx.com, wsa@the-dreams.de, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Mike,

The cadence driver is not in mainline yet. I think for our vendor tree
we can pretty much take it this way.
Regarding getting this into mainline, I'll send another iteration of th=
e
change set and include these changes.

On Mon, 2014-03-10 at 12:12PM +0100, Mike Looijmans wrote:
> Pressing CTRL-C while communicating with an I2C device leads to errat=
ic
> behaviour. The cause is that the controller will interrupt the I2C tr=
ansfer
> in progress, and leave the client device in an undefined state. Many
> drivers do not handle error return codes on I2C transfers. The callin=
g driver
> has no way of telling how much of the transfer has actually completed=
, so
> it cannot reliably determine the device's state.
>=20
> The best solution here is to not handle signals in the I2C bus driver=
 at all,
> but always complete a transaction before returning control.
>=20
> See for a related patch and discussion on this topic:
> http://lkml.org/lkml/2014/1/9/246

Can we get your Signed-off-by, please?

> ---
>  drivers/i2c/busses/i2c-cadence.c |   12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2=
c-cadence.c
> index 86713d6..32ce2ee 100644
> --- a/drivers/i2c/busses/i2c-cadence.c
> +++ b/drivers/i2c/busses/i2c-cadence.c
> @@ -452,16 +452,12 @@ static int cdns_i2c_process_msg(struct cdns_i2c=
 *id, struct i2c_msg *msg,
>  			cdns_i2c_msend(id);
> =20
>  		/* Wait for the signal of completion */
> -		ret =3D wait_for_completion_interruptible_timeout(
> -							&id->xfer_done, HZ);
> -		if (ret < 1) {
> +		ret =3D wait_for_completion_timeout(&id->xfer_done, HZ);
> +		if (ret =3D=3D 0) {

To match the style used throughout the file this should just be
	if (!ret) {


Acked-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

	Thanks,
	S=C3=B6ren
