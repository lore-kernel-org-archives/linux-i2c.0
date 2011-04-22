From: "Heasley, Seth" <seth.heasley-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 2.6.39-rc3] i2c-i801: SMBus patch for Intel Panther
 Point DeviceIDs
Date: Fri, 22 Apr 2011 09:47:34 -0700
Message-ID: <CF9C39F99A89134C9CF9C4CCB68B8DDF25DCDE2DBA@orsmsx501.amr.corp.intel.com>
References: <201104201133.39979.seth.heasley@intel.com>
 <20110422184449.06116327@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110422184449.06116327-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jesse Barnes <jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org>
List-Id: linux-i2c@vger.kernel.org

Hi Jean,

>With each new chip, we have to add the SMBus device ID to pci_ids.h,
>then wait for Jesse to merge that, and only then I can apply the
>changes to i2c-i801.c. This approach slows things down needlessly.
>
>It isn't mandatory to add IDs to pci_ids.h when an ID is only used
>locally in a device driver. So what I would like to propose is that we
>move all PCI_DEVICE_ID_INTEL_*_SMBUS declarations from pci_ids.h to
>i2c-i801.c now. Then you can resubmit your Panther Point patches, and
>the pci and i2c parts will be independent, so Jesse and myself don't
>depend on each other to apply them.
>
>Seth, if you agree, I can take care of the move, or you can send a
>patch doing that, whatever you prefer.

I've been thinking about this one myself, and I tend to agree.  It'd probably be simpler if you went ahead and made the changes, and I'll be happy to review them.

-Seth
