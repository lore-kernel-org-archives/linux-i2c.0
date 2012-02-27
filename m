From: Eugeni Dodonov <eugeni@dodonov.net>
Subject: Re: [Intel-gfx] [PATCH 1/7] drm/i915: add dev_priv to intel_gmbus
Date: Mon, 27 Feb 2012 14:53:37 -0300
Message-ID: <CAC7LmnupmYAs-+pUQw-wYh7+rzeK5wowDQKrmE7hh3j=pvHdvA@mail.gmail.com>
References: <1329255445-6312-1-git-send-email-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1426958189=="
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1329255445-6312-1-git-send-email-daniel.vetter@ffwll.ch>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-i2c@vger.kernel.org, DRI Development <dri-devel@lists.freedesktop.org>
List-Id: linux-i2c@vger.kernel.org

--===============1426958189==
Content-Type: multipart/alternative; boundary=e89a8ffbae5192f27804b9f5cc6a

--e89a8ffbae5192f27804b9f5cc6a
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Feb 14, 2012 at 19:37, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:

> This way we can free up the bus->adaptor.algo_data pointer and make it
> available for use with the bitbanging fallback algo.
>
> Signed-Off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>

Reviewed-by: Eugeni Dodonov <eugeni.dodonov@intel.com>

-- 
Eugeni Dodonov
<http://eugeni.dodonov.net/>

--e89a8ffbae5192f27804b9f5cc6a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Tue, Feb 14, 2012 at 19:37, Daniel Vetter <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:daniel.vetter@ffwll.ch">daniel.vetter@=
ffwll.ch</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

This way we can free up the bus-&gt;adaptor.algo_data pointer and make it<b=
r>
available for use with the bitbanging fallback algo.<br>
<br>
Signed-Off-by: Daniel Vetter &lt;<a href=3D"mailto:daniel.vetter@ffwll.ch">=
daniel.vetter@ffwll.ch</a>&gt;<br></blockquote><div><br>Reviewed-by: Eugeni=
 Dodonov &lt;<a href=3D"mailto:eugeni.dodonov@intel.com">eugeni.dodonov@int=
el.com</a>&gt; <br clear=3D"all">

</div></div><br>-- <br>Eugeni Dodonov<a href=3D"http://eugeni.dodonov.net/"=
 target=3D"_blank"><br></a><br>

--e89a8ffbae5192f27804b9f5cc6a--

--===============1426958189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
dri-devel mailing list
dri-devel@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/dri-devel

--===============1426958189==--
