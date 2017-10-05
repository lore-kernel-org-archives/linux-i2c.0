From: Rudolf Marek <r.marek@assembler.cz>
Subject: Re: [PATCH] i2c: piix4: Fix SMBus port selection for AMD Family 17h
 chips
Date: Thu, 5 Oct 2017 20:34:01 +0200
Message-ID: <29eac89d-d482-bc0a-22e1-166d0f8612be@assembler.cz>
References: <1500162686-21682-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500162686-21682-1-git-send-email-linux@roeck-us.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Guys,

Even in "AMD Family 15h Models 60h-6Fh Processors" [1]
are ports3 and ports4 marked as "Reserved". Maybe we should limit "KERN" to 2 ports?

Thanks
Rudolf

[1] http://support.amd.com/TechDocs/50742_15h_Models_60h-6Fh_BKDG.pdf
