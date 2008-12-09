From: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Subject: Re: Preliminary support for DDR3 in decode-dimms (fwd)
Date: Tue, 9 Dec 2008 10:12:25 +0100
Message-ID: <20081209101225.2ea39aae@hyperion.delvare>
References: <Pine.NEB.4.64.0811230659540.29668@quicky.whooppee.com>
	<20081125103039.2f14bac7@hyperion.delvare>
	<Pine.NEB.4.64.0811250408050.29070@quicky.whooppee.com>
	<20081208145902.5962408c@hyperion.delvare>
	<Pine.NEB.4.64.0812080602060.14436@quicky.whooppee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.NEB.4.64.0812080602060.14436-j58mV80z1I3O+KjX/08HYEEOCMrvLtNR@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Goyette <paul-3orOWTcw9wBWk0Htik3J/w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Paul,

On Mon, 8 Dec 2008 06:24:32 -0800 (PST), Paul Goyette wrote:
> On Mon, 8 Dec 2008, Jean Delvare wrote:
> > Apparently you had to make some changes because assumptions which were
> > correct up to DDR2 are no longer correct for DDR3. Some of these
> > changes look like hacks to me (for example, the readfullspd function
> > and the conditionals it adds to the common code). I really would prefer
> > that we first clean up the script to get rid of improper assumptions,
> > and only after this is done, add support for DDR3. That way I will have
> > two medium patches to review rather than a single large one, and the
> > second patch should be pretty straightforward. This will be way easier
> > for me.
> 
> For FB-DIMMs (which are previously supported) and DDR3, the old checksum 
> over bytes 0-62 no longer exists;  instead, there is a CRC in bytes 126 
> and 127 that covers a variable section of the SPD data.  readfullspd was 
> used to read the entire data, rather than just 0-63.  It would not be 
> too difficult to replace the old (multiple) call to read64.

OK. The reason for not reading all 128 bytes initially is that the
first 64 bytes were enough to verify the checksum, and as reading from
EEPROMs can be slow, it was saving some time for invalid or non-SPD
EEPROMs. But optimizing the code for the failure case doesn't really
make sense, I'd rather have more simple code even if it is slower in a
few corner cases.

> > For example, if the manufacturing information is no longer common to
> > all memory types, then let's move it to a separate function. If
> > checksum handling is type-specific, then let's move it to a separate
> > function as well. I really don't want the main loop to grow
> > indefinitely.
> 
> There are really only two types of validation:
> 
>  	checksum for everything with type < FB-DIMM
>  	CRC for everything >= FB-DIMM
> 
> I'm not sure it makes sense to add a specific call to each memory type's 
> specific processing, especially since it would mean that checksum would 
> not get checked for types that don't have a specific processing routine 
> (ie, the ROMs).

We could always add callbacks for these types. But I don't care too
much about the actual implementation as long as it is clean and works.

> Manufacturing information is indeed no longer completely common.

I moved it to a separate function, it will make it easier to implement
DDR3 support cleanly.

> (...)
> Hopefully I've addressed your comments here.  I'll be happy to make one 
> more pass at this, and submit two separate patches.  But I've already 
> spent a lot more time than I expected (OK, most of that time was spent 
> trying to understand perl!) so if the next submission isn't adequate, 
> I'll have to leave it for someone else to properly integrate.

Thank you. I really don't mean to waste your time here, I just want to
make sure that the code quality is maintained at a proper level, that
we do not introduce any regression, and that maintaining the code in
the future won't be too difficult. Do what you can and I'll do the rest.

In fact I had already started committing some clean-ups. I'll now adjust
your latest patch to apply on top of that. I'll let you know what I am
done and we can pursue with DDR3 support.

Thanks,
-- 
Jean Delvare
