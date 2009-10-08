From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [RFC] misc/at24: add experimental OF support for the generic
	eeprom driver
Date: Thu, 8 Oct 2009 16:59:04 -0600
Message-ID: <fa686aa40910081559v305185b6i6103f83437529f7e@mail.gmail.com>
References: <1255010672-21656-1-git-send-email-w.sang@pengutronix.de>
	<fa686aa40910080737l5b21654cw9c8f7426f9faf7c3@mail.gmail.com>
	<20091008204808.GB8116@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20091008204808.GB8116-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>, devicetree-discuss-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 8, 2009 at 2:48 PM, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
>
>> I think in general, this is the right direction; but I'm not convinced
>> that the right pattern or form has been found yet. =A0What I don't like
>> on this particular patch is that it still hooks of-specific stuff into
>> an arbitrary point in the probe routine.
>>
>> I'd like to see some pattern for retrieving or populating a
>> platform_data structure when one isn't already provided, and
>> regardless of the data source.
>
> I thought about this, too. I just wondered how many drivers would actuall=
y need
> a 'pdata'-preparation routine before probe, and if this would not cause t=
oo
> much overhead for those who don't. But as you say OF might not the only c=
ase
> where this is needed, then it might be a reasonable choice to have an ext=
ra
> call fot setting up pdata. Then again, if we have preparation routines for
> OF,UEFI,... for each and every driver, uh, the bloat :(

It shouldn't be too bad.... I'm toying with the idea of a callable
library function which is passed in a data table of the available
translators.  Can be very simple, and the library function would take
care of pdata allocation and management.  Then the translators can be
kept down to the bare minimum of populating the structure.  If it is
done right, then only the needed translators get compiled in and it
won't add any significant size at all to the drivers.

>> will take a bit of experimentation to come up with the best form for
>> the pdata fetching function, but it will be better contained if it is
>> all at a single place.
>
> I might have a try :)

:-)


-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
