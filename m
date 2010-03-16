From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH V2] MIPS: Octeon: Register EEPROM device on the I2C bus
Date: Tue, 16 Mar 2010 20:06:47 +0100
Message-ID: <20100316200647.3803edf1@hyperion.delvare>
References: <1268026190-18300-1-git-send-email-yang.shi@windriver.com>
        <20100316180946.GC20160@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <20100316180946.GC20160@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Yang Shi <yang.shi@windriver.com>, ddaney@caviumnetworks.com, ben-linux@fluff.org, linux-mips@linux-mips.org, linux-i2c@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Ralf,

On Tue, 16 Mar 2010 19:09:46 +0100, Ralf Baechle wrote:
> On Mon, Mar 08, 2010 at 01:29:50PM +0800, Yang Shi wrote:
> 
> > An SPD resides on 0x50 of the I2C bus on CN56xx/57xx board,
> > register this device.
> 
> I wonder what the use case for this patch is?  Normally Linux doesn't care
> about SPD.

The Linux kernel doesn't care, but user-space may. As a matter of fact,
there is a script out there (decode-dimms, in the i2c-tools package)
decoding the SPD data and presenting it to the user. Some people want
to know the details about their memory modules.

> I also wonder how this will work for configurations with multiple memory
> modules thus multiple SPD EEPROMS.

The kernel code should instantiate one spd device per memory module
(assuming they are all reachable.) Obviously this can't be done in a
static way.

-- 
Jean Delvare
