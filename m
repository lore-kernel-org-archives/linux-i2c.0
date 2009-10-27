From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH v2 2/2] i2c-scmi: support IBM SMBus CMI devices
Date: Tue, 27 Oct 2009 18:24:25 +0100
Message-ID: <20091027182425.31d09784@hyperion.delvare>
References: <20091020231149.GM26149@tux1.beaverton.ibm.com>
	<20091021023016.GC32413@crane-desktop>
	<200910210857.13978.bjorn.helgaas@hp.com>
	<20091021173733.GN26149@tux1.beaverton.ibm.com>
	<20091022071748.GA17917@crane-desktop>
	<20091022174304.GO26149@tux1.beaverton.ibm.com>
	<20091023044451.GB1367@crane-desktop>
	<20091023170311.GC21723@tux1.beaverton.ibm.com>
	<20091025125353.55d3bfad@hyperion.delvare>
	<20091026210024.GS26149@tux1.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20091026210024.GS26149@tux1.beaverton.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: djwong@us.ibm.com
Cc: Crane Cai <crane.cai@amd.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, lenb@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Mon, 26 Oct 2009 14:00:24 -0700, Darrick J. Wong wrote:
> From: Crane Cai <crane.cai@amd.com>
> 
> *) add a new HID for IBM SMBus CMI devices
> *) add methods for IBM SMBus CMI devices
> *) hook different HID with different control methods set
> *) minor tweaks as suggested by Jean Delvare
> 
> Slightly modified by Darrick to use #define'd IBM SMBUS HID from Darrick's ACPI
> scan quirk patch.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> Signed-off-by: Crane Cai <crane.cai@amd.com>
> ---
> 
>  drivers/i2c/busses/i2c-scmi.c |   31 +++++++++++++++++++++++--------
>  1 files changed, 23 insertions(+), 8 deletions(-)

Applied, thanks.

-- 
Jean Delvare
