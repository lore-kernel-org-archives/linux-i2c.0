From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [PATCH 1/10] ARM: PNX4008: convert to clkdev
Date: Tue, 22 Dec 2009 09:47:05 +0300
Message-ID: <acd2a5930912212247j2c3c7d43s879f86da92c0f01@mail.gmail.com>
References: <083DF309106F364B939360100EC290F804F592E901@eu1rdcrdc1wx030.exi.nxp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2139200472=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <083DF309106F364B939360100EC290F804F592E901@eu1rdcrdc1wx030.exi.nxp.com>
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

--===============2139200472==
Content-Type: multipart/alternative; boundary=001485f6299af5beb9047b4b9237

--001485f6299af5beb9047b4b9237
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Dec 22, 2009 at 2:21 AM, Kevin Wells <kevin.wells@nxp.com> wrote:

>
> Signed-off-by: Kevin Wells <kevin.wells@nxp.com>
>

Acked-by: Vitaly Wool <vitalywool@gmail.com>


> ---
>  arch/arm/Kconfig                            |    1 +
>  arch/arm/mach-pnx4008/clock.c               |   73
> +++++++++++++++------------
>  arch/arm/mach-pnx4008/clock.h               |    2 -
>  arch/arm/mach-pnx4008/include/mach/clkdev.h |    7 +++
>  4 files changed, 48 insertions(+), 35 deletions(-)
>  create mode 100644 arch/arm/mach-pnx4008/include/mach/clkdev.h
>
>

--001485f6299af5beb9047b4b9237
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Tue, Dec 22, 2009 at 2:21 AM, Kevin W=
ells <span dir=3D"ltr">&lt;<a href=3D"mailto:kevin.wells@nxp.com">kevin.wel=
ls@nxp.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
<br>
Signed-off-by: Kevin Wells &lt;<a href=3D"mailto:kevin.wells@nxp.com">kevin=
.wells@nxp.com</a>&gt;<br></blockquote><div><br>Acked-by: Vitaly Wool &lt;<=
a href=3D"mailto:vitalywool@gmail.com">vitalywool@gmail.com</a>&gt;<br>=A0<=
br>
</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb=
(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
---<br>
=A0arch/arm/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A01 +<br>
=A0arch/arm/mach-pnx4008/clock.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 73 +++++=
++++++++++------------<br>
=A0arch/arm/mach-pnx4008/clock.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 -<b=
r>
=A0arch/arm/mach-pnx4008/include/mach/clkdev.h | =A0 =A07 +++<br>
=A04 files changed, 48 insertions(+), 35 deletions(-)<br>
=A0create mode 100644 arch/arm/mach-pnx4008/include/mach/clkdev.h<br>
<br></blockquote></div><br>

--001485f6299af5beb9047b4b9237--


--===============2139200472==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2139200472==--
