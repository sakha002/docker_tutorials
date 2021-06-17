import grpc
from google.protobuf import any_pb2

from profanedb.protobuf import db_pb2, db_pb2_grpc, storage_pb2

import test_pb2

def run():
    channel = grpc.insecure_channel('localhost:50051')
    stub = db_pb2_grpc.DbStub(channel)

    to_serialize = test_pb2.KeyInt(
            int_key = 12312
    )

    serializable = any_pb2.Any()
    serializable.Pack(to_serialize)

    stub.Put(db_pb2.PutReq(
        serializable = serializable
    ))


    new_put = test_pb2.NonKeyableNested()
    new_put.int_key =234567
    new_put.nested_nonkeyable_message.boolean =False

    serializable = any_pb2.Any()
    serializable.Pack(new_put)

    stub.Put(db_pb2.PutReq(
        serializable = serializable
    ))

    key = storage_pb2.Key(
            message_type = "schema.NonKeyableNested",
            field = "int_key",
            value = b"234567"
    )

    retrieved = stub.Get(db_pb2.GetReq(
        key = key
    ))

    retrieved_unpacked = test_pb2.NonKeyableNested()

    retrieved.message.Unpack(retrieved_unpacked)

    print(retrieved_unpacked.nested_nonkeyable_message.boolean )


if __name__ == '__main__':
    run()
