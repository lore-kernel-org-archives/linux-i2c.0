From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [RFC] misc/at24: add experimental OF support for the generic
	eeprom driver
Date: Thu, 8 Oct 2009 23:40:47 -0600
Message-ID: <fa686aa40910082240w7fb2a194tcc80e7afe182e781@mail.gmail.com>
References: <1255010672-21656-1-git-send-email-w.sang@pengutronix.de>
	<20091008143301.GA6084@oksana.dev.rtsoft.ru>
	<fa686aa40910080753v6f597b0h4ce835db9f7a653@mail.gmail.com>
	<20091008151007.GA21328@oksana.dev.rtsoft.ru>
	<fa686aa40910080848r459c47baob73fc70a95a08604@mail.gmail.com>
	<20091008202723.GA8116@pengutronix.de>
	<20091009051409.GA2361@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20091009051409.GA2361-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Nate Case <ncase-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-embedded-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 8, 2009 at 11:14 PM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
>> Will check this tomorrow.
>
> And while doing this and figuring the pro/cons of those methods, I stumbl=
ed over this commit:
>
> =A0 =A0 =A0 =A0gpio: pca953x: Get platform_data from OpenFirmware
> =A0 =A0 =A0 =A0(1965d30356c1c65660ba3330927671cfe81acdd5)
>
> It looks to me that it missed all people involved in OF/DT-development an=
d now we
> have undocumented and IMO questionable properties in the kernel.

Hi Nate,

For your future reference, patches that look at the device tree should
also cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org so that new bindings can
be reviewed and common mistakes can be avoided.  It is expected that
new device tree bindings are accompanied with documentation describing
what the binding is for and how it should be used (see
Documentation/powerpc/dts-bindings).

I know this change is already in mainline, but can you please post the
device tree fragment that you're using to describe this chip?  I want
to make sure we don't get stuck with things in the kernel that will be
hard to maintain in the long term.

Thanks,
g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
