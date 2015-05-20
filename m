From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH RFC] i2c: Use ID table to detect ACPI I2C devices
Date: Wed, 20 May 2015 12:48:29 +0300
Message-ID: <20150520094829.GS1490@lahna.fi.intel.com>
References: <1432044209-27858-1-git-send-email-robert.dolca@intel.com>
 <20150520074708.GQ1490@lahna.fi.intel.com>
 <CAFPB+YfvJiL7yNidDQJqq=XbF1hA4QwdBhbVYrwB=wpLkJUOwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFPB+YfvJiL7yNidDQJqq=XbF1hA4QwdBhbVYrwB=wpLkJUOwA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Dolca <robert.dolca@gmail.com>
Cc: Robert Dolca <robert.dolca@intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Daniel Baluta <daniel.baluta@intel.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, May 20, 2015 at 12:39:22PM +0300, Robert Dolca wrote:
> Currently, if the name used for DT (in dts) matches one of the names
> specified in the id table you will have a match. Isn't that an
> intended behavior?

I thought one needs to put IDs to the driver .of_match_table. This is
also what i2c_device_match() is expecting, if I read it right.

BTW, how modules are supposed to be matched if we allow putting ACPI
identifiers to i2c_device_id table?
