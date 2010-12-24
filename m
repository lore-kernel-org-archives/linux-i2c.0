From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c-ocores: add some device tree documentation
Date: Fri, 24 Dec 2010 13:06:38 -0700
Message-ID: <AANLkTikvgjQ=kz6y+n9QfXPMwP5FrdZM7_4s==X-JW-k@mail.gmail.com>
References: <1290615982-1028-1-git-send-email-jonas@southpole.se>
 <1290615982-1028-4-git-send-email-jonas@southpole.se> <20101224040017.GE2491@angua.secretlab.ca>
 <1293183537.8652.4236.camel@satguru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1293183537.8652.4236.camel@satguru>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Fri, Dec 24, 2010 at 2:38 AM, Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org> wrote:
>> > +/*
>> > + * Device tree configuration:
>> > + *
>> > + * Required properties:
>> > + * - compatible =A0 =A0 =A0: "opencores,i2c-ocores"
>>
>> I assume the i2c-ocore interface could end up changing in the future=
=2E
>> This compatible value should have some form of version embedded into
>> it.
>>
>
> Unfortunately, versioning is currently one of OpenCores weak points.
> This driver is based on specification version 0.9 and has implementat=
ion
> version 1.16 according to source and SVN revision 76. =A0I've started=
 an
> internal discussion to try to standardize on something useful, but
> there's no consensus, as of yet. =A0I could make something up here fo=
r the
> compatible value, but I'd rather we find a consistent versioning sche=
me
> that's tenable long-term.
>
> I guess I'll have to sit on these patches for another cycle while we
> think about this.

I think your suggestion below is fine.  I don't see any reason not to
merge this series in 2.6.38.

> =A0Of course, if you have any suggestions, let me know;
> looking at other drivers, there doesn't seem to be a canonical way of
> doing this...
>
> Perhaps: =A0opencores,i2c-cores-0.9-76
> (i.e. {driver}-{spec revision}-{implementation svn rev})

Yes, that sounds appropriate.  For xilinx cores I've pushed for the
full revision in the compatible values.  Newer cores can and should
claim compatibility with an older version that implements the same
interface.  Typically one well known, working version tends to become
the canonical version that newer cores claim compatibility against.

g.
