From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 1/1] i2c: taos-evm: replace simple_strtoul by kstrtou8
Date: Wed, 18 Nov 2015 18:26:25 +0200
Message-ID: <CAHp75Vepu9=DjsV2JdR2pRMQw+0GJTJktudg44GnCgbms0B7mw@mail.gmail.com>
References: <1447851356-6248-1-git-send-email-clabbe.montjoie@gmail.com>
	<1447851356-6248-2-git-send-email-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447851356-6248-2-git-send-email-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: jdelvare@suse.com, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org

On Wed, Nov 18, 2015 at 2:55 PM, LABBE Corentin
<clabbe.montjoie@gmail.com> wrote:
> The simple_strtoul function is marked as obsolete.
> This patch replace it by kstrtou8.
>

Only one concern. simple_strto* goes through the string until it has
an invalid character or \0. In your case kstrtou8 will fail the
transfer. So, is there possible cases when HW returns such data?

And just a style nitpicks below.

>                 if (p[0] =3D=3D 'x') {
> -                       data->byte =3D simple_strtol(p + 1, NULL, 16)=
;
> +                       /*
> +                        * voluntarily dropping error code of kstrtou=
8 since all

-> Voluntarily=E2=80=A6

> +                        * error code that it could return are invali=
d according
> +                        * to Documentation/i2c/fault-codes

-> =E2=80=A6codes.

> +                        */
> +                       if (kstrtou8(p + 1, 16, &data->byte))
> +                               return -EPROTO;

--=20
With Best Regards,
Andy Shevchenko
