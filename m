From: Crane Cai <crane.cai@amd.com>
Subject: Re: [PATCH] i2c-scmi: Quirk to work on IBM machines with broken
	BIOSes
Date: Wed, 21 Oct 2009 10:30:16 +0800
Message-ID: <20091021023016.GC32413@crane-desktop>
References: <20091020231149.GM26149@tux1.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20091020231149.GM26149@tux1.beaverton.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: lenb@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Darrick,

On Tue, Oct 20, 2009 at 04:11:49PM -0700, Darrick J. Wong wrote:
> On some old IBM workstations and desktop computers, the BIOS presents in the
> DSDT an SMBus object that is missing the HID identifier that the i2c-scmi
> driver looks for.  It also omits the leading "_" in the method names (it should
> be _SBR, not SBR_).  Modify the ACPI device scan code to insert the missing HID
> if it finds an IBM system with such an object, and modify the i2c-scmi driver
> to handle the odd method names.
I have a suggestion:
You can need not to add quirk in acpi part, instead you can add your ACPI device
HID in i2c-scmi with your specificied methods set.

-- 
Best Regards,
- Crane

