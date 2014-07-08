From: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Subject: Re: ddc/ci over i2c
Date: Wed, 9 Jul 2014 00:20:17 +0200
Message-ID: <20140709002017.4c2b332e@endymion.delvare>
References: <53BBC97B.5020805@minsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53BBC97B.5020805-9+fK6rGKj7RBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sanford Rockowitz <rockowitz-9+fK6rGKj7RBDgjK7y7TUQ@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

Hi Sanford,

On Tue, 08 Jul 2014 03:35:39 -0700, Sanford Rockowitz wrote:
> I've been trying to use i2c-dev to read and control monitor settings, 
> using the DDC/CI protocol to communicate with address 0x37 on device 
> /dev/i2c-n.  Things are sort of working (details below), But it's not 
> clear to me to what extent I'm hitting real limits, or if I just don't 
> know what I'm doing.  Perhaps I shouldn't even be trying to use i2c-dev 
> for this application.

i2c-dev should work fine for what you're doing. 

> Advice appreciated. And if there's a more 
> appropriate place to post this question, I'd appreciate hearing that as 
> well.
> 
> To review: A monitor is accessed via device /dev/i2c-n, created by the 
> video device driver.  EDID data is found by reading address 0x50.  The 
> monitor's settings are read and written at address 0x37.
> 
> I can communicate with the monitor if either the open-source nouveau or 
> radeon drivers are loaded.  Both support i2c_smbus_read_i2c_block_data() 
> and i2c_smbus_write_i2c_block_data(), which put the right bytes on the 
> wire and handle the ack and nack bits as per the DDC specification. (See 
> documentation file i2c/smbus-protocol.)
> 
> For the nouveau driver running on Fedora 20, "lsmod | grep i2c" reports:
> 
> i2c_piix4              22155  0
> i2c_algo_bit           13257  1 nouveau
> i2c_dev                14027  0
> i2c_core               38656  6 
> drm,i2c_dev,i2c_piix4,drm_kms_helper,i2c_algo_bit,nouveau
> 
> 
> Here's a simplified example (minimal error checking) of how I'm reading 
> the monitor's brightness setting:
> 
>     int fh = open("/dev/i2c-0",  O_NONBLOCK|O_RDWR);

Out of curiosity, why O_NONBLOCK?

>     ioctl(fh, I2C_SLAVE, 0x37);
> 
>     unsigned char zeroByte = 0x00;
>     write(fh, &zeroByte, 1);   // seems to be necessary to reset monitor state
> 
>     unsigned char ddc_cmd_bytes[] = {
>        0x6e,              // address 0x37, shifted left 1 bit
>        0x51,              // source address
>        0x02 | 0x80,       // number of DDC data bytes, with high bit set
>        0x01,              // DDC Get Feature Command
>        0x10,              // Feature, Luminosity
>        0x00,              // checksum, to be set
>     };
>     ddc_cmd_bytes[5] = ddc_checksum(ddc_cmd_bytes, 5);    // calculate DDC checksum on all bytes
>     i2c_smbus_write_i2c_block_data(fh, ddc_cmd_bytes[1], sizeof(ddc_cmd_bytes)-2, ddc_cmd_bytes+2);
>     // alt: write(fh, ddc_cmd_bytes+1, sizeof(ddc_cmd_bytes)-1); // see  below

Yes, that would be equivalent, because there is no direction change for
I2C block writes.

>     usleep(5000);
> 
>     unsigned char ddc_response_bytes[12];
>     unsigned char cmd_byte = 0x00;   // apparently ignored, can be anything
>     i2c_smbus_read_i2c_block_data(fh, cmd_byte, 11, readbuf+1);
>     // alt read(fh, readbuf+1, 11);   // see below

I don't know the DDC/CI protocol so I can't tell how you are supposed
to read the response, but I can tell you that
i2c_smbus_read_i2c_block_data and read are not equivalent.
i2c_smbus_read_i2c_block_data first writes a command bytes, then
there's a direction change (a.k.a. restart condition in I2C dialect)
and then data is read from the chip. read, OTOH, reads data from the
chip directly.

But the fact that the command byte is ignored, would be compatible with
your theory that both are equivalent.

>     ddc_response_bytes[0] = 0x50;     // for proper checksum calculation
>     int calculated_checksum = ddc_checksum(readbuf, 11);
>     assert(readbuf[11] == calculated_checksum);
>     int response_len = ddc_response_bytes[2] & 0x7f;       // always 8 for DDC Get Value response
>     // now parse the response data
> 
> 
> When issuing the DDC get feature command (code 0x01), a fixed data block 
> of 12 data bytes is returned as shown above (as counted from the 
> i2c_cmsbus_read_i2c_block_data() perspective.

Your code reads 11 data bytes, not 12.

> However, the DDC Get 
> Capabilities request (0xf3), can return up to 39 bytes (fixed DDC data 
> of 7 bytes plus a "fragment" of up to 32 bytes, depending on the monitor 
> being communicated with.).   This is greater than the 32 byte max data 
> size supported by i2c_smbus_read_i2c_block_data() (constant 
> I2C_SMBUS_I2C_BLOCK_MAX in i2c-dev.h).  And indeed, I've seen 
> i2c_smbus_read_i2c_block_data() return truncated responses.

The 32 bytes limit is inherited from SMBus block limits. In practice,
i2c_smbus_read/write_i2c_block_data is useful with SMBus controllers
which can't do full I2C but implement these functions. If you need to
go beyond this limit then your code won't work on simple SMBus
controllers so you shouldn't use i2c_smbus_read_i2c_block_data, instead
you should use the I2C_RDRW ioctl. See eepromer/eeprom.c in i2c-tools
for an example.

> Now things get interesting.
> 
> Simply using write() and read() seems to work, when the 
> i2c_smbus_..._i2c_block_data() calls in the above code are replaced by 
> the commented out write() and read() lines.  So apparently apparently 
> write() and read() are handling the algorithm bits (start, top, ack, 
> nack) properly.

Yes, write and read are fully I2C compliant. What they can't do is
direction changes in the middle of a message. Maybe DDC/CI doesn't
require that, I don't know. I could never get my hands on the
specification.

> Now come the key questions:
> 
> Am I just getting lucky here, or is the i2c_dev driver (or one of the 
> drivers it calls) really doing the right thing for managing the 
> algorithm bits for the i2c DDC protocol?

Well your code looks mostly sane. It's hard for me to tell if it is
fully correct without seeing the DDC/CI specification.

> Is there a better way to use lower level services in i2c-dev?

If DDC/CI needs direction changes inside messages, then you should use
the I2C_RDWD ioctl. If not then you're OK with read and write.

> Should I really be writing a device driver?

You could but then you would have to define a user interface. Which
might be good anyway. i2c-dev requires root capabilities while ideally
regular users should be able to change the contrast and brightness of
the display. But presumably this should all go through X11 anyway.

> Finally, the proprietary video drivers.
> 
> The proprietary nvidia driver creates the /dev/i2c-n devices.  I can 
> read the monitor EDID information on bus address 0x50. and get the 
> functionality flags using ioctl I2C_FUNCS.   Functions 
> ic2_smbus_read_i2c_block_data() and is2_smbus_write_i2c_block_data() are 
> not supported (flags I2C_FUNC_SMBUS_READ_I2C_BLOCK and 
> I2C_FUNC_SMBUS_WRITE_I2C_BLOCK are not set).  Attempting to call these 
> functions fails with errno=22 (EINVAL - invalid argument) if module 
> i2c_algo_bit has not been loaded, and errno=5 (EIO - IO Error) if it has.

Hard to comment without seeing the code, and I don't want to see it.
But I suppose that the binary driver is taking benefit of hardware I2C
controllers inside the graphics chipset, while the open source drivers
are doing everything in software using i2c-algo-bit over GPIOs. Hardware
implementations are faster and more reliable, but possibly less
flexible. It is also possible that the hardware can do more than the
drivers allows but Nvidia did not bother implementing full support.

> Trying to use write() and read() as described above also fails. write() 
> appears to succeed, but read() returns invalid data.

Again, can't comment on that without seeing the driver code.

> Appendix F of the Nvidia driver README discusses i2c support.  It 
> appears to be quite dated, referring to the 2.4 and 2.6 kernels. 

That doesn't necessarily mean much, 2.6 == 3.x in many respects.

> According to this document, only the following functionality is 
> supported, which would be consistent with what I've seen: I2C_FUNC_I2C, 
> I2C_FUNC_SMBUS_QUICK, I2C_FUNC_SMBUS_BYTE, I2C_FUNC_SMBUS_BYTE_DATA, 
> I2C_FUNC_SMBUS_WORD_DATA

I would trust the output of i2cdetect -F more than the documentation.

This suggests that the driver authors were lazy and/or did something
stupid. A driver that can do I2C_FUNC_I2C, can do most SMBus transfers,
including I2C block transfers (which despite the name are close to
SMBus transfers.)

OTOH, if the driver really supports I2C_FUNC_I2C then the I2C_RDWR
ioctl should do the trick. But I wouldn't hope too much, because then
read and write should also work, when your experiments apparently show
they do not.

> As for the proprietary fglrx driver, it doesn't even create the 
> /dev/i2c-n devices.   End of story.

Correct :(

-- 
Jean Delvare
SUSE L3 Support
