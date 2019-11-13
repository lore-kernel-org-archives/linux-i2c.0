From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 2/3] i2c: smbus: use get/put_unaligned_le16 when
 working with word data
Date: Wed, 13 Nov 2019 11:39:37 -0800
Message-ID: <20191113193937.GQ13374@dtor-ws>
References: <20191112203132.163306-1-dmitry.torokhov@gmail.com>
 <20191112203132.163306-3-dmitry.torokhov@gmail.com>
 <099e8f9c-354a-8756-a79b-e66c72d36aa7@lucaceresoli.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <099e8f9c-354a-8756-a79b-e66c72d36aa7@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.orgi, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-i2c@vger.kernel.org

Hi Luca,

On Wed, Nov 13, 2019 at 10:47:42AM +0100, Luca Ceresoli wrote:
> Hi Dmitry,
> 
> On 12/11/19 21:31, Dmitry Torokhov wrote:
> > It is potentially more performant, and also shows intent more clearly,
> > to use get_unaligned_le16() and put_unaligned_le16() when working with
> > word data.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > ---
> > 
> > Changes in v3:
> > - split put_unaligned_le16 into a separate patch
> > - more call sites converted to get/put_unaligned_le16
> > 
> >  drivers/i2c/i2c-core-smbus.c | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
> > index f8708409b4dbc..7b4e2270eeda1 100644
> > --- a/drivers/i2c/i2c-core-smbus.c
> > +++ b/drivers/i2c/i2c-core-smbus.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/i2c.h>
> >  #include <linux/i2c-smbus.h>
> >  #include <linux/slab.h>
> > +#include <asm/unaligned.h>
> >  
> >  #include "i2c-core.h"
> >  
> > @@ -370,8 +371,7 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
> >  			msg[1].len = 2;
> >  		else {
> >  			msg[0].len = 3;
> > -			msgbuf0[1] = data->word & 0xff;
> > -			msgbuf0[2] = data->word >> 8;
> > +			put_unaligned_le16(data->word, msgbuf0 + 1);
> >  		}
> >  		break;
> >  	case I2C_SMBUS_PROC_CALL:
> > @@ -379,8 +379,7 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
> >  		read_write = I2C_SMBUS_READ;
> >  		msg[0].len = 3;
> >  		msg[1].len = 2;
> > -		msgbuf0[1] = data->word & 0xff;
> > -		msgbuf0[2] = data->word >> 8;
> > +		put_unaligned_le16(data->word, msgbuf0 + 1);
> >  		break;
> >  	case I2C_SMBUS_BLOCK_DATA:
> >  		if (read_write == I2C_SMBUS_READ) {
> > @@ -487,7 +486,7 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
> >  			break;
> >  		case I2C_SMBUS_WORD_DATA:
> >  		case I2C_SMBUS_PROC_CALL:
> > -			data->word = msgbuf1[0] | (msgbuf1[1] << 8);
> > +			data->word = get_unaligned_le16(msgbuf1);
> 
> Well, msgbuf1 cannot be unaligned, so it looks like you just need to
> convert little endian to host endian. Perhaps __le16_to_cpu(msgbuf1) is
> better (and equally or more efficient).

Well, msgbuf1 (as is any other variable unless adjusted by special
alignment attribute) is naturally aligned for its own data type (which
for u8 means it can start at any address), but that does not mean that
is is aligned for the purpose of storing word data. In fact, the
preceding msgbuf0 variable is 32 + 3 = 35 bytes long, which means that
msgbuf1 is starting on an odd address, and is definitely not aligned for
word access and using __le16_to_cpu to fetch that word will trap on some
architectures.

Thanks.

-- 
Dmitry
