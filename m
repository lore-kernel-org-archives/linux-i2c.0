From: Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
Subject: Re: [PATCH 3/3] i2c-ocores: add some device tree documentation
Date: Fri, 24 Dec 2010 10:38:57 +0100
Message-ID: <1293183537.8652.4236.camel@satguru>
References: <1290615982-1028-1-git-send-email-jonas@southpole.se>
	 <1290615982-1028-4-git-send-email-jonas@southpole.se>
	 <20101224040017.GE2491@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20101224040017.GE2491-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

> > +/*
> > + * Device tree configuration:
> > + *
> > + * Required properties:
> > + * - compatible      : "opencores,i2c-ocores"
> 
> I assume the i2c-ocore interface could end up changing in the future.
> This compatible value should have some form of version embedded into
> it.
> 

Unfortunately, versioning is currently one of OpenCores weak points.
This driver is based on specification version 0.9 and has implementation
version 1.16 according to source and SVN revision 76.  I've started an
internal discussion to try to standardize on something useful, but
there's no consensus, as of yet.  I could make something up here for the
compatible value, but I'd rather we find a consistent versioning scheme
that's tenable long-term.

I guess I'll have to sit on these patches for another cycle while we
think about this.  Of course, if you have any suggestions, let me know;
looking at other drivers, there doesn't seem to be a canonical way of
doing this...

Perhaps:  opencores,i2c-cores-0.9-76
(i.e. {driver}-{spec revision}-{implementation svn rev})

/Jonas

PS: Honestly not crazy about the name 'i2c-ocores' either as it doesn't
match the name of the upstream Verilog project which is called,
unfortunately, simply 'i2c'.  This driver, however, has been upstream
for a while so I guess we're stuck with it.
