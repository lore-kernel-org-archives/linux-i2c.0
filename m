From: Kyle <kl-I2D4Bl1yN1BBDgjK7y7TUQ@public.gmane.org>
Subject: Re: install functioning lm-sensors on CentOS 5 - Intel/Xeon
 combo. Help pls.
Date: Wed, 27 Aug 2008 00:11:58 +1000
Message-ID: <48B40F2E.1090600@attitia.com>
References: <48B3AE8C.9090505@attitia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6770189224163157855=="
Return-path: <i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
In-Reply-To: <48B3AE8C.9090505-I2D4Bl1yN1BBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.lm-sensors.org/pipermail/i2c>
List-Post: <mailto:i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
List-Help: <mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=help>
List-Subscribe: <http://lists.lm-sensors.org/mailman/listinfo/i2c>,
	<mailto:i2c-request-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org?subject=subscribe>
Sender: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
Errors-To: i2c-bounces-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
To: i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
List-Id: linux-i2c@vger.kernel.org

This is a multi-part message in MIME format.
--===============6770189224163157855==
Content-Type: multipart/alternative;
	boundary="------------060904060709050404050202"

This is a multi-part message in MIME format.
--------------060904060709050404050202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'm not sure how this is the wrong mailing list.

I'm looking for assistance on getting lm-sensors installed on a 
particular OS / CPU combination.  My subject line didn't originally 
state "install lm-sensors on CentOS 5 - Intel/Xeon combo. Help pls." as 
I would expect that on the lm-sensors mailing list, that would be 
understood.

Is this not the mailing list to ask for assistance in installing 
lm-sensors? If not, pls do let me know to which mailing list I should 
post? If I knew which mailing list to ask, I would've posted there.

------------------------------------------------------------------------
Kind Regards

Kyle



Kyle wrote:
> Hi folks,
>
> I'm hoping someone can hep me out pls. I've installed lm-sensors in 
> the past in 2.4 kernels and it all just worked.
>
> But I cannot for the life of me understand what is happening with or 
> figure out what I need for my CentOS 5 / 2.6 kernel install.
>
> I have read snippets which "SEEM" to indicate all of the modules I 
> need are already compiled into or modularised with the base 2.6 Kernel 
> (CentOS is of course a downline from RedHat EL), but don't really make 
> it clear. When looking in 'make menuconfig', the modules listed as 
> required for lm-sensors don't seem to match up with what I read.
>
> I've read on the lm-sensors site that I "MAY" need a different driver 
> with the XEON CPU, but I can't figure out how to tell and don't want 
> to mess up a new install.
>
> When running sensors-detect, it appears to fail to find just about 
> everything. Basically, the abridged output of sensors-detect is as 
> follows;
>
> =========================================
> Probing for PCI bus adapters...
> Sorry, no PCI bus adapters found.
>
> i2c-dev is not loaded. Do you want to load it now? (YES/no):
> Module loaded succesfully.
>
> Next adapter: SMBus I801 adapter at 2000
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x08
> Client found at address 0x10
> Client found at address 0x30
> Client found at address 0x32
> Client found at address 0x44
> Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
> Client found at address 0x50
> Probing for `SPD EEPROM'... Success!
>    (confidence 8, driver `eeprom')
> Probing for `DDC monitor'... Failed!
> Probing for `Maxim MAX6900'... Failed!
> Client found at address 0x52
> Probing for `SPD EEPROM'... Success!
>    (confidence 8, driver `eeprom')
> Client found at address 0x69
>
> Do you want to scan the ISA bus? (YES/no):
> Probing for `IPMI BMC KCS'
>  Trying address 0x0ca0... Success!
>    (confidence 4, driver `bmcsensors')        [KL] ALL OTHERS FAILED.
>
> Do you want to scan for Super I/O sensors? (YES/no):
> [KL] ALL FAILED.
>
> Do you want to scan for secondary Super I/O sensors? (YES/no):
> [KL] ALL FAILED
>
>
> Driver `eeprom' (should be inserted):
>  Detects correctly:
>  * Bus `SMBus I801 adapter at 2000'
>    Busdriver `i2c-i801', I2C address 0x50
>    Chip `SPD EEPROM' (confidence: 8)
>  * Bus `SMBus I801 adapter at 2000'
>    Busdriver `i2c-i801', I2C address 0x52
>    Chip `SPD EEPROM' (confidence: 8)
>
> Driver `bmcsensors' (should be inserted):
>  Detects correctly:
>  * ISA bus address 0x0ca0 (Busdriver `i2c-isa')
>    Chip `IPMI BMC KCS' (confidence: 4)
>
> [KL] It then offers up the changes to rc.local and modprobe.conf. But 
> within that, there's
>
> # Warning: the required module bmcsensors is not currently installed 
> on your system.
> # For status of 2.6 kernel ports see 
> http://secure.netroedge.com/~lm78/supported.html
> # If driver is built-in to the kernel, or unavailable, comment out the 
> following line.
> modprobe bmcsensors
>
> [KL] How can it detect a driver if it's apparently NOT installed on 
> the system. Where do I get hold of the correct bmcsensors module?
> ===========================================
>
> Can I ask any one of you to help out pls and ask me the right 
> questions so I know/can figure out just what the hell I should be 
> looking for?
>
>

--------------060904060709050404050202
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000099">
I'm not sure how this is the wrong mailing list. <br>
<br>
I'm looking for assistance on getting lm-sensors installed on a
particular OS / CPU combination.&nbsp; My subject line didn't originally
state "install lm-sensors on CentOS 5 - Intel/Xeon combo. Help pls." as
I would expect that on the lm-sensors mailing list, that would be
understood. <br>
<br>
Is this not the mailing list to ask for assistance in installing
lm-sensors? If not, pls do let me know to which mailing list I should
post? If I knew which mailing list to ask, I would've posted there. <br>
<br>
<div class="moz-signature"><span
 style="padding: 0px; color: rgb(0, 0, 153); font-style: normal; font-variant: normal; font-weight: normal; font-size: 11px; line-height: normal; font-size-adjust: none; font-stretch: normal; font-family: Verdana,Arial,Helvetica,sans-serif;">
<hr align="left" color="#000099" size="1" width="200">Kind Regards
<p>Kyle </p>
</span></div>
<br>
<br>
Kyle wrote:
<blockquote cite="mid:48B3AE8C.9090505-I2D4Bl1yN1BBDgjK7y7TUQ@public.gmane.org" type="cite">Hi
folks,
  <br>
  <br>
I'm hoping someone can hep me out pls. I've installed lm-sensors in the
past in 2.4 kernels and it all just worked.
  <br>
  <br>
But I cannot for the life of me understand what is happening with or
figure out what I need for my CentOS 5 / 2.6 kernel install.
  <br>
  <br>
I have read snippets which "SEEM" to indicate all of the modules I need
are already compiled into or modularised with the base 2.6 Kernel
(CentOS is of course a downline from RedHat EL), but don't really make
it clear. When looking in 'make menuconfig', the modules listed as
required for lm-sensors don't seem to match up with what I read.
  <br>
  <br>
I've read on the lm-sensors site that I "MAY" need a different driver
with the XEON CPU, but I can't figure out how to tell and don't want to
mess up a new install.
  <br>
  <br>
When running sensors-detect, it appears to fail to find just about
everything. Basically, the abridged output of sensors-detect is as
follows;
  <br>
  <br>
=========================================
  <br>
Probing for PCI bus adapters...
  <br>
Sorry, no PCI bus adapters found.
  <br>
  <br>
i2c-dev is not loaded. Do you want to load it now? (YES/no):
  <br>
Module loaded succesfully.
  <br>
  <br>
Next adapter: SMBus I801 adapter at 2000
  <br>
Do you want to scan it? (YES/no/selectively):
  <br>
Client found at address 0x08
  <br>
Client found at address 0x10
  <br>
Client found at address 0x30
  <br>
Client found at address 0x32
  <br>
Client found at address 0x44
  <br>
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
  <br>
Client found at address 0x50
  <br>
Probing for `SPD EEPROM'... Success!
  <br>
&nbsp;&nbsp; (confidence 8, driver `eeprom')
  <br>
Probing for `DDC monitor'... Failed!
  <br>
Probing for `Maxim MAX6900'... Failed!
  <br>
Client found at address 0x52
  <br>
Probing for `SPD EEPROM'... Success!
  <br>
&nbsp;&nbsp; (confidence 8, driver `eeprom')
  <br>
Client found at address 0x69
  <br>
  <br>
Do you want to scan the ISA bus? (YES/no):
  <br>
Probing for `IPMI BMC KCS'
  <br>
&nbsp;Trying address 0x0ca0... Success!
  <br>
&nbsp;&nbsp; (confidence 4, driver `bmcsensors')&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [KL] ALL OTHERS FAILED.
  <br>
  <br>
Do you want to scan for Super I/O sensors? (YES/no):
  <br>
[KL] ALL FAILED.
  <br>
  <br>
Do you want to scan for secondary Super I/O sensors? (YES/no):
  <br>
[KL] ALL FAILED
  <br>
  <br>
  <br>
Driver `eeprom' (should be inserted):
  <br>
&nbsp;Detects correctly:
  <br>
&nbsp;* Bus `SMBus I801 adapter at 2000'
  <br>
&nbsp;&nbsp; Busdriver `i2c-i801', I2C address 0x50
  <br>
&nbsp;&nbsp; Chip `SPD EEPROM' (confidence: 8)
  <br>
&nbsp;* Bus `SMBus I801 adapter at 2000'
  <br>
&nbsp;&nbsp; Busdriver `i2c-i801', I2C address 0x52
  <br>
&nbsp;&nbsp; Chip `SPD EEPROM' (confidence: 8)
  <br>
  <br>
Driver `bmcsensors' (should be inserted):
  <br>
&nbsp;Detects correctly:
  <br>
&nbsp;* ISA bus address 0x0ca0 (Busdriver `i2c-isa')
  <br>
&nbsp;&nbsp; Chip `IPMI BMC KCS' (confidence: 4)
  <br>
  <br>
[KL] It then offers up the changes to rc.local and modprobe.conf. But
within that, there's
  <br>
  <br>
# Warning: the required module bmcsensors is not currently installed on
your system.
  <br>
# For status of 2.6 kernel ports see
<a class="moz-txt-link-freetext" href="http://secure.netroedge.com/~lm78/supported.html">http://secure.netroedge.com/~lm78/supported.html</a>
  <br>
# If driver is built-in to the kernel, or unavailable, comment out the
following line.
  <br>
modprobe bmcsensors
  <br>
  <br>
[KL] How can it detect a driver if it's apparently NOT installed on the
system. Where do I get hold of the correct bmcsensors module?
  <br>
===========================================
  <br>
  <br>
Can I ask any one of you to help out pls and ask me the right questions
so I know/can figure out just what the hell I should be looking for?
  <br>
  <br>
  <br>
</blockquote>
</body>
</html>

--------------060904060709050404050202--


--===============6770189224163157855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
i2c mailing list
i2c-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org
http://lists.lm-sensors.org/mailman/listinfo/i2c
--===============6770189224163157855==--
