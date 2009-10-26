From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: Re: [PATCH 2/2] acpi: support IBM SMBus CMI devices
Date: Mon, 26 Oct 2009 13:53:41 -0700
Message-ID: <20091026205341.GQ26149@tux1.beaverton.ibm.com>
References: <20091020231149.GM26149@tux1.beaverton.ibm.com> <20091021023016.GC32413@crane-desktop> <200910210857.13978.bjorn.helgaas@hp.com> <20091021173733.GN26149@tux1.beaverton.ibm.com> <20091022071748.GA17917@crane-desktop> <20091022174304.GO26149@tux1.beaverton.ibm.com> <20091023044451.GB1367@crane-desktop> <20091023170311.GC21723@tux1.beaverton.ibm.com> <20091025125353.55d3bfad@hyperion.delvare>
Reply-To: djwong@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091025125353.55d3bfad@hyperion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Crane Cai <crane.cai@amd.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, lenb@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Sun, Oct 25, 2009 at 12:53:53PM +0100, Jean Delvare wrote:
> > +		else if (!probe_ibm_smbus_device(device))
> > +			acpi_add_id(device, ACPI_SMBUS_IBM_HID);
> 
> I am not responsible for the ACPI code, but... wouldn't it make sense
> to rename probe_ibm_smbus_device() to acpi_ibm_smbus_match() and have
> it follow the same convention as acpi_dock_match() and
> acpi_bay_match()? To make the code more consistent.

Sure.

> > +	{ACPI_SMBUS_IBM_HID, (kernel_ulong_t)&ibm_smbus_methods},
> 
> As both patches depend on each other and one is useless without the
> other, you might as well sequence them the other way around, so that
> you touch this line only once.

Will do.

> Other that these details, I like the patch. If this helps with ACPI
> resource conflicts, even better :)

It should. :)  I'll reroll the patch set shortly.

--D
