From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] i2c: Enable Cadence driver for ARM64
Date: Mon, 26 Oct 2015 16:45:59 +0000
Message-ID: <20151026164559.GP597@x1>
References: <893f828f3ac665d80746589af3617dc462315329.1445868589.git.michal.simek@xilinx.com>
 <20151026143236.GK597@x1>
 <20151026144425.GA5588@katana>
 <20151026150048.GO597@x1>
 <562E416B.8@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38604 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbbJZQqG (ORCPT
	<rfc822;linux-i2c@vger.kernel.org>); Mon, 26 Oct 2015 12:46:06 -0400
Received: by wicll6 with SMTP id ll6so123375245wic.1
        for <linux-i2c@vger.kernel.org>; Mon, 26 Oct 2015 09:46:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <562E416B.8@osg.samsung.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, monstr@monstr.eu, Andrew Bresticker <abrestic@chromium.org>, David Box <david.e.box@linux.intel.com>, Kamal Dasu <kdasu.kdev@gmail.com>, Joachim Eastwood <manabian@gmail.com>, Zhangfei Gao <zhangfei.gao@linaro.org>, linux-i2c@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Neelesh Gupta <neelegup@linux.vnet.ibm.com>, Subhendu Sekhar Behera <sbehera@broadcom.com>

On Tue, 27 Oct 2015, Javier Martinez Canillas wrote:

> Hello,
>=20
> On 10/27/2015 12:00 AM, Lee Jones wrote:
> > On Mon, 26 Oct 2015, Wolfram Sang wrote:
> >> On Mon, Oct 26, 2015 at 02:32:36PM +0000, Lee Jones wrote:
> >>> Regarding your address list -- it's too big.  Most of your addres=
sees
> >>> don't care about this patch.  Please be more selective when sendi=
ng
> >>> patches to people, most of us have enough (relevant) mail as it i=
s.
> >>
> >> Probably more effective than to write every user of get_maintainer=
=2Epl:
> >> Patch it to not use git history by default and win the fight ;)
> >
>=20
> Agreed, coincidentally I was telling people today that get_maintainer=
s.pl
> only provides a suggestion and that it should not be followed blindly=
=2E
>=20
> > Geert wrote to Joe today.  Let's see if he can improve things.
> >=20
>=20
> What about something like the following patch until Joe writes a more
> smarter git fallback version?
>=20
> From d6dc34810d24f33afb3c158d519966c1b6167a2f Mon Sep 17 00:00:00 200=
1
> From: Javier Martinez Canillas <javier@osg.samsung.com>
> Date: Mon, 26 Oct 2015 23:46:52 +0900
> Subject: [RFC PATCH] get_maintainer: Don't fallback to git by default
>=20
> The get_maintainer.pl script could be used to get a list of people th=
at
> has to be in the copy list when posting patches for a given file but =
it
> defaults to git fallback so the list returned isn't really relevant a=
nd
> submitters are posting patches to random developers that just happene=
d
> to touch that file in the past.
>=20
> Disable git fallback so get_maintainer.pl only returns the informatio=
n
> that is in MAINTAINERS by default.
>=20
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
>  scripts/get_maintainer.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Works for me.  Although you should have used get_maintainer.pl and
CC'ed Joe. ;)

I never did this before -- it was both odd and fun:

  $ ./scripts/get_maintainer.pl -f scripts/get_maintainer.pl=20
  Joe Perches <joe@perches.com> (maintainer:GET_MAINTAINER SCRIPT)

> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index 98bae869f6d0..b52ae26270e8 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -29,7 +29,7 @@ my $email_git =3D 0;
>  my $email_git_all_signature_types =3D 0;
>  my $email_git_blame =3D 0;
>  my $email_git_blame_signatures =3D 1;
> -my $email_git_fallback =3D 1;
> +my $email_git_fallback =3D 0;
>  my $email_git_min_signatures =3D 1;
>  my $email_git_max_maintainers =3D 5;
>  my $email_git_min_percent =3D 5;

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
