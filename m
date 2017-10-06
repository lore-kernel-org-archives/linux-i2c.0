From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] i2c: piix4: Fix SMBus port selection for AMD Family 17h
 chips
Date: Fri, 6 Oct 2017 10:18:21 -0700
Message-ID: <20171006171821.GA14922@roeck-us.net>
References: <1500162686-21682-1-git-send-email-linux@roeck-us.net>
 <29eac89d-d482-bc0a-22e1-166d0f8612be@assembler.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <29eac89d-d482-bc0a-22e1-166d0f8612be@assembler.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Rudolf Marek <r.marek@assembler.cz>
Cc: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, Oct 05, 2017 at 08:34:01PM +0200, Rudolf Marek wrote:
> Hi Guys,
> 
> Even in "AMD Family 15h Models 60h-6Fh Processors" [1]
> are ports3 and ports4 marked as "Reserved". Maybe we should limit "KERN" to 2 ports?
> 

Maybe, if we are sure that this applies to all CPU models supported
by the driver. That should be a separate patch, though. 

Thanks,
Guenter
