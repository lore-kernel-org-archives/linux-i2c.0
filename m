From: Stephen Douthit <stephend@adiengineering.com>
Subject: Re: [PATCH 0/2] i2c: ismt: Fix length handling for SMBus block reads
Date: Mon, 28 Aug 2017 09:50:32 -0400
Message-ID: <f1d1d452-892a-82ff-c6a2-1e2512d9ed70@adiengineering.com>
References: <1502140260-13789-1-git-send-email-stephend@adiengineering.com>
 <20170814193105.cosdlbf5gypazlzn@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170814193105.cosdlbf5gypazlzn@ninjato>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: seth.heasley@intel.com, nhorman@tuxdriver.com, danp@adiengineering.com, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

On 8/14/2017 3:31 PM, Wolfram Sang wrote:
> On Mon, Aug 07, 2017 at 05:10:58PM -0400, Stephen Douthit wrote:
>> Hello all,
>>
>> We ran into an issue where the ipmi_ssif and i2c-ismt drivers don't
>> agree on the format for data returned by i2c_smbus_read_block_data()
>>
>> Looking at the traffic on the wire with a beagle analyzer:
>> -----
>> Packet Details   (Values in hex; [S] = Start condition;
>>                   [P] = Stop condition; * = No Ack)
>> [S] <10:R> 12 1C 01 00 00 80 02 1C 02 8F BE 12 00 25 12 41 01 00 00* [P]
>> -----
>>
>> Looking at the matching kernel trace:
>> -----
>> kssif0010-759   [001] ....  1435.891090: smbus_read: i2c-0 a=010 f=0000 c=3 BLOCK_DATA
>> kssif0010-759   [001] ....  1436.202906: smbus_reply: i2c-0 a=010 f=0000 c=3 BLOCK_DATA l=20 [13-12-1c-01-00-00-80-02-1c-02-8f-be-12-00-25-12-41-01-00-00]
>> kssif0010-759   [001] ....  1436.202908: smbus_result: i2c-0 a=010 f=0000 c=3 BLOCK_DATA rd res=0
>> -----
>>
>> So basically the byte count already precedes the data in the dma_buffer,
>> then the driver sticks desc->rxbytes in front of this resulting in the
>> trace above.
>>
>> The first patch tackles this.
>>
>> The second patch in the series adds a sanity check on the byte count
>> supplied by the slave device.  This might be a nice to have, but is
>> probably less critical.
> 
> Both patches look good to me. Seth, Neil, do you agree?
> 

Ping.

Not sure what the usual review time is, let me know if this is premature.
