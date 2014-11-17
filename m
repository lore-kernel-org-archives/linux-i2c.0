From: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] at24: extend driver to allow writing via i2c_smbus_write_byte_data
Date: Mon, 17 Nov 2014 08:40:32 +0100
Message-ID: <CAH9NwWca2jdurQGRddTJwF=9and3+8C5uctg0UR+iGfmjofrZw@mail.gmail.com>
References: <1412845678-18933-1-git-send-email-christian.gmeiner@gmail.com>
 <20141113001628.GA2062@katana> <20141113174235.GE1275@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141113174235.GE1275@katana>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Wolfram

Thanks a lot!

2014-11-13 18:42 GMT+01:00 Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>:
> On Thu, Nov 13, 2014 at 01:16:28AM +0100, Wolfram Sang wrote:
>> On Thu, Oct 09, 2014 at 11:07:58AM +0200, Christian Gmeiner wrote:
>> > I have a at24 EEPROM connected via i2c bus provided by ISCH i2c
>> > bus driver. This bus driver does not support
>> > I2C_FUNC_SMBUS_WRITE_I2C_BLOCK and so I was looking for a way
>> > to be able to write the eeprom. This patch adds support for
>> > I2C_SMBUS_BYTE_DATA writing via i2c_smbus_write_byte_data.
>> > It is quite slow, but it works.
>> >
>> > Signed-off-by: Christian Gmeiner <christian.gmeiner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> Applied to for-next, thanks!
>
> Since I haven't pushed out yet, I did
> s/use_smbuse_write/use_smbus_write/g on the file.
>
--
Christian Gmeiner, MSc

https://soundcloud.com/christian-gmeiner
