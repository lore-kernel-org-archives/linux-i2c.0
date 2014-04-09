From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH RFC] i2c algo, Add i2c-algo-i801 driver [v1]
Date: Wed, 9 Apr 2014 22:25:46 +0200
Message-ID: <20140409222546.71f3343e@endymion.delvare>
References: <1397060563-30431-1-git-send-email-prarit@redhat.com>
	<1397061392.5276.11.camel@x230>
	<20140409205614.2ee3c25c@endymion.delvare>
	<1397069892.5276.24.camel@x230>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1397069892.5276.24.camel@x230>
Sender: linux-acpi-owner@vger.kernel.org
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: linux-i2c@vger.kernel.org, rjw@rjwysocki.net, seth.heasley@intel.com, prarit@redhat.com, janet.morgan@intel.com, bhelgaas@google.com, mstowe@redhat.com, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Wed, 9 Apr 2014 18:58:12 +0000, Matthew Garrett wrote:
> On Wed, 2014-04-09 at 20:56 +0200, Jean Delvare wrote:
> > Hi Matthew,
> > > 
> > > These systems simply don't safely support OS-level i2c access.
> > 
> > But people need that. And they have been for almost a decade. It's
> > about time that hardware vendors realize that. Yes, I mean Intel,
> > amongst others.
> 
> There is no safe way to do it. If the user is happy to accept the
> inherent dangers, the user can pass the kernel parameter.

Oh, there is. There always is. It would just take a few engineers, an
equal amount of chairs and pencils, a table and a few sheets of paper.
There's no technical reason why this problem can't be solved.

-- 
Jean Delvare
SUSE L3 Support
