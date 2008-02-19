From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 2/2] i2c-ibm_iic driver
Date: Wed, 20 Feb 2008 00:54:37 +0100
Message-ID: <200802200054.38282.arnd@arndb.de>
References: <4784FED1.2040206@pikatech.com> <47BB63AE.2090903@pikatech.com>
	<20080220104133.e9722e62.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <20080220104133.e9722e62.sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Sean MacLennan <smaclennan-Qtffpm9i2AVWk0Htik3J/w@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

On Wednesday 20 February 2008, Stephen Rothwell wrote:
> > > - =A0 =A0 =A0 depends on IBM_OCP
> > > + =A0 =A0 =A0 depends on IBM_OCP || PPC_MERGE
> =

> not PPC_OF? =A0or even OF (give the sparc guys the opportunity to build it
> for us :-))?
> =


Right, I was looking for that option but couldn't find it. I would
guess sparc doesn't work because it's lacking the necessary I/O functions,
in_8 and out_8 that are powerpc specific.

so maybe:
	depends on PPC
	depends on IBM_OCP || OF

	Arnd <><

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
