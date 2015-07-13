From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH v1] HID: cp2112: fix byte order in SMBUS operations
Date: Mon, 13 Jul 2015 13:23:52 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507131322180.7522@pobox.suse.cz>
References: <1436504671-2485-1-git-send-email-ellen@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1436504671-2485-1-git-send-email-ellen@cumulusnetworks.com>
Sender: linux-input-owner@vger.kernel.org
To: Ellen Wang <ellen@cumulusnetworks.com>
Cc: borneo.antonio@gmail.com, dbarksdale@uplogix.com, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On Thu, 9 Jul 2015, Ellen Wang wrote:

> Change all occurrences of be16 to le16 in cp2112_xfer(),
> because SMBUS words are little endian, not big endian.
> 
> Signed-off-by: Ellen Wang <ellen@cumulusnetworks.com>

Alright, this means that I2C_SMBUS_WORD_DATA and I2C_SMBUS_PROC_CALL have 
been terminally broken since the very beginning and noone noticed.

Does this mean that those commands are in practice mostly unused anyway? 
This is important for 4.2 vs 4.3 consideration.

Thanks,

-- 
Jiri Kosina
SUSE Labs
