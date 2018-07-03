#pragma once

#include "../protocols.h"
#include <mutex>
#include <cstdarg>

class socket_out : public message_protocol {
public:
  int fd;
  socket_out(int fd) : fd(fd) {};
  virtual void text_message(int resp_id, const std::string& text);
  virtual void err(int resp_id, const std::string& text, const std::string& path, int line_number);
  virtual void err(int resp_id, const std::string& text);
  virtual void device_slot(int resp_id, input_source* device, output_slot* slot);
  virtual void device_plug(int resp_id, input_source* device, std::string action);

  virtual void end_response(int resp_id, int ret_val);
  virtual ~socket_out() {};
  std::mutex write_lock;
private:
  int osc_msg(const std::string& path, int id, const std::string& argtypes, ...);
};
