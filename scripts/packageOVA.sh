#!/bin/bash

BUILDVMNAME=$1

rm -f /ACS-Appliance/output/$BUILDVMNAME-esxi.ova
ovftool /data/packer/vmware/$BUILDVMNAME.vmx /data/packer/vmware/$BUILDVMNAME-esxi.ovf
sed -i '/<\/VirtualHardwareSection>/i \      <vmw:Config ovf:required=\"false\" vmw:key=\"nestedHVEnabled\" vmw:value=\"true\"/>' /data/packer/vmware/$BUILDVMNAME-esxi.ovf
sed -i '/<\/VirtualHardwareSection>/i \      <vmw:Config ovf:required=\"false\" vmw:key=\"vhv.enable\" vmw:value=\"TRUE"/>' /data/packer/vmware/$BUILDVMNAME-esxi.ovf
tar -cf /ACS-Appliance/output/$BUILDVMNAME-esxi.ova -C /data/packer/vmware $BUILDVMNAME-esxi.ovf -C /data/packer/vmware  $BUILDVMNAME-esxi-disk1.vmdk
rm -rf /data/packer/vmware/