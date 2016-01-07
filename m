From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 00/16] intel-lpss: support non-ACPI platforms
Date: Thu, 7 Jan 2016 10:43:22 +0200
Message-ID: <20160107084322.GU1770@lahna.fi.intel.com>
References: <1448896304-87928-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1488447.PO5a3v7KWa@vostro.rjw.lan>
 <568C040F.2070000@redhat.com>
 <1855560.2DW9QAnCKL@vostro.rjw.lan>
 <568D3EA5.7040207@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <568D3EA5.7040207@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Laura Abbott <labbott@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Kevin Fenzi <kevin@scrye.com>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@the-dreams.de>, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-i2c@vger.kernel.org

On Wed, Jan 06, 2016 at 08:19:49AM -0800, Laura Abbott wrote:
> I picked up all the patches from the device-properties merge but the
> problem still shows up. Are there others I should pick up? Hardware
> details about the touchpad are at https://bugzilla.redhat.com/show_bug.cgi?id=1275718#c34

Can you get full dmesg of the failure and acpidump as well? I did not
find those from the bug report.

Also dmesg of non-failure case would be nice.
