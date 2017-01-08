From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/7] x86/platform/intel/iosf_mbi: Add a mutex for punit
 access
Date: Sun, 08 Jan 2017 17:35:54 +0200
Message-ID: <1483889754.26691.20.camel@linux.intel.com>
References: <20170108134427.8392-1-hdegoede@redhat.com>
         <20170108134427.8392-2-hdegoede@redhat.com>
         <1483888594.26691.8.camel@linux.intel.com>
         <d6acfed3-f778-fe6a-eda7-3de5e2ce9bb9@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:50570 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752386AbdAHPjO (ORCPT <rfc822;linux-i2c@vger.kernel.org>);
        Sun, 8 Jan 2017 10:39:14 -0500
In-Reply-To: <d6acfed3-f778-fe6a-eda7-3de5e2ce9bb9@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Daniel Vetter <daniel.vetter@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel@lists.freedesktop.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-i2c@vger.kernel.org

On Sun, 2017-01-08 at 16:30 +0100, Hans de Goede wrote:
> Hi,
> 
> On 08-01-17 16:16, Andy Shevchenko wrote:
> > On Sun, 2017-01-08 at 14:44 +0100, Hans de Goede wrote:
> > > One some systems the punit accesses the pmic to change various
> > > voltages
> > > through the same bus as other kernel drivers use for e.g. battery
> > > monitoring.
> > > 
> > > If a driver sends requests to the punit which require the punit to
> > > access
> > > the pmic bus while another driver is also accessing the pmic bus
> > > various
> > > bad things happen.
> > > 
> > > This commit adds a mutex to protect the punit against simultaneous
> > > accesses
> > > and 2 functions to lock / unlock this mutex.
> > > 
> > > Note on these systems the i2c-bus driver will request a sempahore
> > > from
> > > the
> > > punit for exclusive access to the pmic bus when i2c drivers are
> > > accessing
> > > it, but this does not appear to be sufficient, we still need to
> > > avoid
> > > making certain punit requests during the access window to avoid
> > > problems.
> > 
> > I'm fine with the patch, but please spell
> > P-Unit
> > PMIC
> 
> In the commit msg and comments, not in code you mean I assume ?

Correct.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
