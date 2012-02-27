From: Eugeni Dodonov <eugeni@dodonov.net>
Subject: Re: [PATCH] drm/i915: i2c: unconditionally set up gpio
	fallback
Date: Mon, 27 Feb 2012 15:29:56 -0300
Message-ID: <CAC7LmntsLPXJ0iMT9oWBqm676rSRCQdjTwGmb_YqsoLpawb=sw@mail.gmail.com>
References: <CAC7LmnvP0wUroQq6VJ3QeoWDy=WEk_UcfkKiuYx=hWZ8WT6tMQ@mail.gmail.com>
	<1330366963-12623-1-git-send-email-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0266491536=="
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1330366963-12623-1-git-send-email-daniel.vetter@ffwll.ch>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-i2c@vger.kernel.org, DRI Development <dri-devel@lists.freedesktop.org>
List-Id: linux-i2c@vger.kernel.org

--===============0266491536==
Content-Type: multipart/alternative; boundary=e89a8ff254b075000e04b9f64edd

--e89a8ff254b075000e04b9f64edd
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Feb 27, 2012 at 15:22, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:

> This way we can simplify the setup and teardown a bit.
>
> Because we don't actually allocate anything anymore for the force_bit
> case, we can now convert that into a boolean.
>
> Also and the functionality supported by the bit-banging together with
> what gmbus can do, so that this doesn't randomly change any more.
>
> v2: Chris Wilson noticed that I've mixed up && and & ...
>
> v3: Clarify an if block as suggested by Eugeni Dodonov.
>
> Signed-Off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>

Reviewed-by: Eugeni Dodonov <eugeni.dodonov@intel.com>

-- 
Eugeni Dodonov
<http://eugeni.dodonov.net/>

--e89a8ff254b075000e04b9f64edd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Mon, Feb 27, 2012 at 15:22, Daniel Vetter <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:daniel.vetter@ffwll.ch">daniel.vetter@=
ffwll.ch</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

<div class=3D"im">This way we can simplify the setup and teardown a bit.<br=
>
<br>
Because we don&#39;t actually allocate anything anymore for the force_bit<b=
r>
case, we can now convert that into a boolean.<br>
<br>
Also and the functionality supported by the bit-banging together with<br>
what gmbus can do, so that this doesn&#39;t randomly change any more.<br>
<br>
v2: Chris Wilson noticed that I&#39;ve mixed up &amp;&amp; and &amp; ...<br=
>
<br>
</div>v3: Clarify an if block as suggested by Eugeni Dodonov.<br>
<div class=3D"im"><br>
Signed-Off-by: Daniel Vetter &lt;<a href=3D"mailto:daniel.vetter@ffwll.ch">=
daniel.vetter@ffwll.ch</a>&gt;<br></div></blockquote><div><br>Reviewed-by: =
Eugeni Dodonov &lt;<a href=3D"mailto:eugeni.dodonov@intel.com">eugeni.dodon=
ov@intel.com</a>&gt; <br>

<br></div></div>-- <br>Eugeni Dodonov<a href=3D"http://eugeni.dodonov.net/"=
 target=3D"_blank"><br></a><br>

--e89a8ff254b075000e04b9f64edd--

--===============0266491536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Intel-gfx mailing list
Intel-gfx@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/intel-gfx

--===============0266491536==--
