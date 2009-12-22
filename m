From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [PATCH 9/10] ARM: PNX4008: convert i2c-pnx to use clk API
	enable/disable calls
Date: Tue, 22 Dec 2009 09:53:22 +0300
Message-ID: <acd2a5930912212253q557401d8x39b4e80d9db58b61@mail.gmail.com>
References: <083DF309106F364B939360100EC290F804F592E909@eu1rdcrdc1wx030.exi.nxp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0059438790=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <083DF309106F364B939360100EC290F804F592E909@eu1rdcrdc1wx030.exi.nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Wells <kevin.wells@nxp.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-i2c@vger.kernel.org

--===============0059438790==
Content-Type: multipart/alternative; boundary=001485f450466c87f8047b4ba97e

--001485f450466c87f8047b4ba97e
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Dec 22, 2009 at 2:23 AM, Kevin Wells <kevin.wells@nxp.com> wrote:

>
> Signed-off-by: Kevin Wells <kevin.wells@nxp.com>
>

Acked-by: Vitaly Wool <vitalywool@gmail.com>



> ---
>  arch/arm/mach-pnx4008/clock.c |   12 ++++++------
>  drivers/i2c/busses/i2c-pnx.c  |   18 +++++++++---------
>  2 files changed, 15 insertions(+), 15 deletions(-)
>

--001485f450466c87f8047b4ba97e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Tue, Dec 22, 2009 at 2:23 AM, Kevin W=
ells <span dir=3D"ltr">&lt;<a href=3D"mailto:kevin.wells@nxp.com">kevin.wel=
ls@nxp.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
<br>
Signed-off-by: Kevin Wells &lt;<a href=3D"mailto:kevin.wells@nxp.com">kevin=
.wells@nxp.com</a>&gt;<br></blockquote><div><br>Acked-by: Vitaly Wool &lt;<=
a href=3D"mailto:vitalywool@gmail.com">vitalywool@gmail.com</a>&gt;<br><br>
=A0<br></div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px so=
lid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
---<br>
=A0arch/arm/mach-pnx4008/clock.c | =A0 12 ++++++------<br>
=A0drivers/i2c/busses/i2c-pnx.c =A0| =A0 18 +++++++++---------<br>
=A02 files changed, 15 insertions(+), 15 deletions(-)<br></blockquote></div=
><br>

--001485f450466c87f8047b4ba97e--


--===============0059438790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0059438790==--
