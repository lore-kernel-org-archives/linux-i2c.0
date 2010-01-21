From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 04/11] i2c-mpc: Add MPC5121 I2C bus support
Date: Thu, 21 Jan 2010 10:12:17 -0700
Message-ID: <fa686aa41001210912r5fd2a5a4g8a072e0c41ee4107@mail.gmail.com>
References: <1263932653-3634-1-git-send-email-agust@denx.de>
	<1263932653-3634-5-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1263932653-3634-5-git-send-email-agust-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, dzu-ynQEQJNshbs@public.gmane.org, wd-ynQEQJNshbs@public.gmane.org, Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, John Rigby <jcrigby-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Tue, Jan 19, 2010 at 1:24 PM, Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org> wro=
te:
> From: Piotr Ziecik <kosmo-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
>
> =A0 =A0- Update Kconfig for i2c-mpc driver.
> =A0 =A0- Enable I2C interrupts on MPC5121.
>
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mp=
c.c
> index f627001..84eeb25 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -540,6 +540,29 @@ static int __devinit fsl_i2c_probe(struct of_dev=
ice *op,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (of_device_is_compatible(op->node, "fsl,mpc5121-i2c"=
)) {

Rather than doing stuff like this with explicit compatible checks in
the probe hook, consider using the .data pointer in the of match
table.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
