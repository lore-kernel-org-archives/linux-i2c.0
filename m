From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v7 1/4] i2c-mpc: use __devinit[data] for initialization
	functions and data
Date: Tue, 16 Feb 2010 11:40:35 -0700
Message-ID: <fa686aa41002161040kada217ds1f63d363157e08ab@mail.gmail.com>
References: <1265813711-16794-1-git-send-email-wg@grandegger.com>
	<1265813711-16794-2-git-send-email-wg@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1265813711-16794-2-git-send-email-wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Cc: Linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Feb 10, 2010 at 7:55 AM, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org=
> wrote:
> From: Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
>
> "__devinit[data]" has not yet been used for all initialization functi=
ons
> and data. To avoid truncating lines, the struct "mpc_i2c_match_data" =
has
> been renamed to "mpc_i2c_data", which is even the better name.
>
> Signed-off-by: Wolfgang Grandegger <wg-ynQEQJNshbs@public.gmane.org>
> Tested-by: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Between patch 1 & 2 is not bisectable.  Functions still called
*_setclock in this patch, but referenced as *_setup in the structure.
Please respin.

Also ...

> +static struct mpc_i2c_data mpc_i2c_data_52xx __devinitdata =3D {
> + =A0 =A0 =A0 .setup =3D mpc_i2c_setup_52xx,
> +};
> +
> +static struct mpc_i2c_data mpc_i2c_data_8313 __devinitdata =3D {
> + =A0 =A0 =A0 .setup =3D mpc_i2c_setup_8xxx,
> +};
> +
> +static struct mpc_i2c_data mpc_i2c_data_8543 __devinitdata =3D {
> + =A0 =A0 =A0 .setup =3D mpc_i2c_setup_8xxx,
> + =A0 =A0 =A0 .prescaler =3D 2,
> +};
> +
> +static struct mpc_i2c_data mpc_i2c_data_8544 __devinitdata =3D {
> + =A0 =A0 =A0 .setup =3D mpc_i2c_setup_8xxx,
> + =A0 =A0 =A0 .prescaler =3D 3,
> +};
> +
> =A0static const struct of_device_id mpc_i2c_of_match[] =3D {
> - =A0 =A0 =A0 {.compatible =3D "mpc5200-i2c",
> - =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_s=
etclock_52xx,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> - =A0 =A0 =A0 },
> - =A0 =A0 =A0 {.compatible =3D "fsl,mpc5200b-i2c",
> - =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_s=
etclock_52xx,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> - =A0 =A0 =A0 },
> - =A0 =A0 =A0 {.compatible =3D "fsl,mpc5200-i2c",
> - =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_s=
etclock_52xx,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> - =A0 =A0 =A0 },
> - =A0 =A0 =A0 {.compatible =3D "fsl,mpc8313-i2c",
> - =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_s=
etclock_8xxx,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> - =A0 =A0 =A0 },
> - =A0 =A0 =A0 {.compatible =3D "fsl,mpc8543-i2c",
> - =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_s=
etclock_8xxx,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prescaler =3D 2,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> - =A0 =A0 =A0 },
> - =A0 =A0 =A0 {.compatible =3D "fsl,mpc8544-i2c",
> - =A0 =A0 =A0 =A0.data =3D &(struct mpc_i2c_match_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .setclock =3D mpc_i2c_s=
etclock_8xxx,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prescaler =3D 3,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 {.compatible =3D "mpc5200-i2c", .data =3D &mpc_i2c_data=
_52xx, },
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc5200b-i2c", .data =3D &mpc_i2c=
_data_52xx, },
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc5200-i2c", .data =3D &mpc_i2c_=
data_52xx, },
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc8313-i2c", .data =3D &mpc_i2c_=
data_8313, },
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc8543-i2c", .data =3D &mpc_i2c_=
data_8543, },
> + =A0 =A0 =A0 {.compatible =3D "fsl,mpc8544-i2c", .data =3D &mpc_i2c_=
data_8544, },

=2E.. what was wrong with the old format of declaring the .data
structures inline with the match table?

g.
