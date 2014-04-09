From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH RFC] i2c algo, Add i2c-algo-i801 driver [v1]
Date: Wed, 09 Apr 2014 13:02:05 -0400
Message-ID: <53457D0D.7020805@redhat.com>
References: <1397060563-30431-1-git-send-email-prarit@redhat.com> <1397061392.5276.11.camel@x230>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1397061392.5276.11.camel@x230>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "seth.heasley@intel.com" <seth.heasley@intel.com>, "khali@linux-fr.org" <khali@linux-fr.org>, "janet.morgan@intel.com" <janet.morgan@intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "mstowe@redhat.com" <mstowe@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-i2c@vger.kernel.org



On 04/09/2014 12:36 PM, Matthew Garrett wrote:
> On Wed, 2014-04-09 at 12:22 -0400, Prarit Bhargava wrote:
>> RFC and a work in progress ... I need to go through and do a bunch of error
>> condition checking, more testing, etc.  I'm just throwing this out there to see
>> if anyone has any major concerns about doing something like this.
> 
> This isn't really a good approach. These aren't standardised ACPI
> methods, so you have no guarantee that they exist. The fact that a

I've looked at the ACPI dump across six different systems (3 different vendors,
and an intel whitebox), and the data appears to be identical.  Could Intel
change these?  Yes, of course they could, but that's no different from any other
undocumented driver in the kernel.

> method with one of these names exists is no guarantee that it has the
> same behaviour as the ones on your board. There's no guarantee that
> you're not racing against the firmware.
> 

I think there is -- AFAICT the operations are serialized; if they aren't that is
an associated risk.  Hopefully someone from Intel will lend a hand here and let
me know if I'm doing something horrible ;)

> These systems simply don't safely support OS-level i2c access.

Possibly -- my interpretation of the ACPI AML could be wrong but it seems like
these operations are here for the OS.

I'm not denying there is a lot of risk in doing this...

P.
