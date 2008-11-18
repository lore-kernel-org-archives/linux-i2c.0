From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: [lm-sensors] #2361: i2c and lm_sensors do not work on Slackware 12.1 with kernel 2.6.27.6
Date: Tue, 18 Nov 2008 11:42:21 +0000
Message-ID: <20081118114221.GA28706@srcf.ucam.org>
References: <040.878a61a6a191c2ece367aefb3b3bc643@lm-sensors.org> <049.52c5d9ff015802332972920378e356e9@lm-sensors.org> <200811182017.43109.twinreverb@puresimplicity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200811182017.43109.twinreverb-v3ax9e/3W6w7GzjB842lBqxOck334EZe@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Delahunt <twinreverb-v3ax9e/3W6w7GzjB842lBqxOck334EZe@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

On Tue, Nov 18, 2008 at 08:17:42PM +0900, Robert Delahunt wrote:
> How is it fixed?  ACPI and sensors should be able to live together.  If I 
> can't have one without the other, in my opinion, this is a blind spot for 
> both projects.  Has anyone brought this up to the kernel ACPI developers to 
> see if they can "unhide" or "expose" the hardware monitoring?

Hitting thermal regulation hardware directly can cause problems if 
you're also using ACPI, since there's no way of implementing locking 
between the firmware and the operating system in this case. Since most 
thermal monitoring hardware is accessed using indexed registers, having 
two pieces of code trying to access the hardware simultaneously will 
give bogus values and potentially result in hardware damage. Many 
laptops therefore hide the smbus from the operating system. While it's 
possible to unhide them, it's not a good idea.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
